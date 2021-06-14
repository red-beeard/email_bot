//
//  BotController.swift
//  
//
//  Created by Red Beard on 20.05.2021.
//



import Vapor
#if canImport(FoundationNetworking)
import FoundationNetworking
#endif

class BotController {
    private let urlMessage = "https://botapi.tamtam.chat/messages"
    private let welcomeMessage = """
        Hello. I am a bot that can collect mail from e-mail and send it to Tam-Tam. If you want to add a mailbox, click on the /add command. You can do it right in my message)
        """
    private let dontUnderstandMessage = """
        I do not understand you
        """
    
    func handleWebHook(req: Request) throws -> HTTPResponseStatus {
        print("Полученный запрос:")
        print(req.description)
        print(req.body.string ?? "Ничего")
        print("\n")
        
        let webHook = try req.content.decode(Update.self)
        print("Update Type: \(webHook.updateType.rawValue)")
        print("\n")
        
        switch webHook.updateType {
        case .messageCreated:
            let webHook = try req.content.decode(MessageCreatedUpdate.self)
            try handleMessageCreated(webHook)
        case .botStarted:
            let webHook = try req.content.decode(BotStartedUpdate.self)
            try sendMessage(with: welcomeMessage, to: webHook.chatId)
        case .userAdded:
            let webHook = try req.content.decode(UserAddedToChatUpdate.self)
            try handleUserAddedToChatUpdate(webHook)
        default: print("Другой вебхук")
        }
        
        return HTTPStatus.ok
    }
    
    func handleMessageCreated(_ update: MessageCreatedUpdate) throws {
        guard let chatId = update.message.recipient.chatId else { return }
        guard let text = update.message.body.text else {
            try sendMessage(with: dontUnderstandMessage, to: chatId)
            return
        }
        
        if text == "/add" {
            try sendKeyboardServices(to: chatId, and: update.message.sender.userId)
        } else {
            try sendMessage(with: dontUnderstandMessage, to: chatId)
        }
    }
    
    func handleUserAddedToChatUpdate(_ update: UserAddedToChatUpdate) throws {
        print("user added")
        return
    }
    
    private func getKeyboardServices(for userId: Int64) -> InlineKeyboardAttachmentRequest {
        let buttons = [[LinkButton(text: "Google", url: GoogleAuthController().getUrlForAuth(for: userId))]]
        let keyboardPayload = InlineKeyboardAttachmentRequestPayload(buttons: buttons)
        let keyboard = InlineKeyboardAttachmentRequest(payload: keyboardPayload)
        return keyboard
    }
    
    private func getKeyboardChat(for email: String) -> InlineKeyboardAttachmentRequest {
        let buttons = [[ChatButton(text: "Open chat", chatTitle: email)]]
        let keyboardPayload = InlineKeyboardAttachmentRequestPayload(buttons: buttons)
        let keyboard = InlineKeyboardAttachmentRequest(payload: keyboardPayload)
        return keyboard
    }
    
    private func sendKeyboardServices(to chatId: Int64, and userId: Int64) throws {
        let keyboard = getKeyboardServices(for: userId)
        let message = NewMessageBody(with: "Select service:", with: [keyboard])
        let json = try JSONEncoder().encode(message)
        
        guard var url = URLComponents(string: urlMessage) else { return }
        var items: [URLQueryItem] = []
        let parameters = ["access_token" : Environment.tamTamToken, "chat_id": String(chatId)]
        for (key, value) in parameters {
            items.append(URLQueryItem(name: key, value: value))
        }
        url.queryItems = items
        var request = URLRequest(url: (url.url)!)
        // Явное извлечения опционала плохая практика
        request.httpMethod = "POST"
        request.httpBody = json
        request.setValue("application/json", forHTTPHeaderField: "Content-Type")
        
        print("\nОтправляемый запрос:")
        print(String(data: json, encoding: .utf8) ?? "Не распечатал")
        print("\n")
        
        let session = URLSession(configuration: .ephemeral)
        session.dataTask(with: request) { (data, response, error) in
            guard let data = data else { return }
            if let json = try? JSONSerialization.jsonObject(with: data, options: .mutableContainers),
               let jsonData = try? JSONSerialization.data(withJSONObject: json, options: .prettyPrinted) {
                print(String(decoding: jsonData, as: UTF8.self))
            } else {
                print("json отсутствует")
            }
        }.resume()
    }
    
    func sendKeyboardChat(to userId: Int64, for email: String) throws {
        let keyboard = getKeyboardChat(for: email)
        let message = NewMessageBody(with: "You are signed in for \(email)", with: [keyboard])
        let json = try JSONEncoder().encode(message)
        
        guard var url = URLComponents(string: urlMessage) else { return }
        url.queryItems = [
            URLQueryItem(name: "access_token", value: Environment.tamTamToken),
            URLQueryItem(name: "user_id", value: String(userId))
        ]
        var request = URLRequest(url: (url.url)!)
        // Явное извлечения опционала плохая практика
        request.httpMethod = "POST"
        request.httpBody = json
        request.setValue("application/json", forHTTPHeaderField: "Content-Type")
        
        print("\nОтправляемый запрос:")
        print(String(data: json, encoding: .utf8) ?? "Не распечатал")
        print("\n")
        
        let session = URLSession(configuration: .ephemeral)
        session.dataTask(with: request) { (data, response, error) in
            guard let data = data else { return }
            if let json = try? JSONSerialization.jsonObject(with: data, options: .mutableContainers),
               let jsonData = try? JSONSerialization.data(withJSONObject: json, options: .prettyPrinted) {
                print(String(decoding: jsonData, as: UTF8.self))
            } else {
                print("json отсутствует")
            }
        }.resume()
    }
    
    func sendMessage(with text: String, to chatId: Int64) throws {
        let message = NewMessageBody(with: text)
        let json = try JSONEncoder().encode(message)
        
        guard var url = URLComponents(string: urlMessage) else { return }
        url.queryItems = [
            URLQueryItem(name: "access_token", value: Environment.tamTamToken),
            URLQueryItem(name: "chat_id", value: String(chatId))
        ]
        var request = URLRequest(url: (url.url)!) // Явное извлечения опционала плохая практика
        request.httpMethod = "POST"
        request.httpBody = json
        request.setValue("application/json", forHTTPHeaderField: "Content-Type")
        
        let session = URLSession(configuration: .ephemeral)
        session.dataTask(with: request) { (data, response, error) in
            guard let data = data else { return }
            if let json = try? JSONSerialization.jsonObject(with: data, options: .mutableContainers),
               let jsonData = try? JSONSerialization.data(withJSONObject: json, options: .prettyPrinted) {
                print(String(decoding: jsonData, as: UTF8.self))
            } else {
                print("json отсутствует")
            }
        }.resume()
    }
    
    func sendMessage(with text: String, to userId: String) throws {
        let message = NewMessageBody(with: text)
        let json = try JSONEncoder().encode(message)
        
        guard var url = URLComponents(string: urlMessage) else { return }
        url.queryItems = [
            URLQueryItem(name: "access_token", value: Environment.tamTamToken),
            URLQueryItem(name: "user_id", value: userId)
        ]
        var request = URLRequest(url: (url.url)!) // Явное извлечения опционала плохая практика
        request.httpMethod = "POST"
        request.httpBody = json
        request.setValue("application/json", forHTTPHeaderField: "Content-Type")
        
        let session = URLSession(configuration: .ephemeral)
        session.dataTask(with: request) { (data, response, error) in
            guard let data = data else { return }
            if let json = try? JSONSerialization.jsonObject(with: data, options: .mutableContainers),
               let jsonData = try? JSONSerialization.data(withJSONObject: json, options: .prettyPrinted) {
                print(String(decoding: jsonData, as: UTF8.self))
            } else {
                print("json отсутствует")
            }
        }.resume()
    }
}
