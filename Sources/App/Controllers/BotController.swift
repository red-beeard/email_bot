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
    private let token = "vlIHSMAYdD4N3V_1LHKeeFJS9a9mJ7vu2eg6VLXzVWA"
    private let urlMessage = "https://botapi.tamtam.chat/messages"
    private let welcomeMessage = """
        Hello. I am a bot that can collect mail from e-mail and send it to Tam-Tam. If you want to add a mailbox, click on the /add command. You can do it right in my message)
        """
    
    func handleWebHook(req: Request) throws -> HTTPResponseStatus {
        let webHook = try req.content.decode(Update.self)
        print(webHook.updateType)
        print(webHook.timestamp)
        
        switch webHook.updateType {
        case .message_created:
            let webHook = try req.content.decode(MessageCreatedUpdate.self)
            if let chatId = webHook.message.recipient.chatId {
                try sendMessage(with: "Привет))", to: chatId)
                try sendKeyboard(to: chatId)
            }
        case .bot_started:
            let webHook = try req.content.decode(BotStartedUpdate.self)
            try sendMessage(with: welcomeMessage, to: webHook.chatId)
        default: print("Другой вебхук")
        }
        print(try req.content.decode(Update.self).timestamp)
        let message = try req.content.decode(MessageCreatedUpdate.self)
        print(message.updateType)
        print(message.description())
        
        
        
        return HTTPStatus.ok
    }
    
    private func getKeyboard() -> InlineKeyboardAttachmentRequest {
        let buttons = [[Button(type: .callback, text: "Google", payload: "GoogleAuth", intent: nil)]]
        let keyboardPayload = InlineKeyboardAttachmentRequestPayload(buttons: buttons)
        let keyboard = InlineKeyboardAttachmentRequest(
            type: .inline_keyboard,
            payload: keyboardPayload
        )
        return keyboard
    }
    
    private func sendKeyboard(to chatId: Int64) throws {
        let keyboard = [getKeyboard()]
        let message = NewMessageBody(with: "Выберите сервис", with: keyboard)
        let json = try JSONEncoder().encode(message)
        
        guard var url = URLComponents(string: urlMessage) else { return }
        var items: [URLQueryItem] = []
        let parameters = ["access_token" : token, "chat_id": String(chatId)]
        for (key, value) in parameters {
            items.append(URLQueryItem(name: key, value: value))
        }
        url.queryItems = items
        var request = URLRequest(url: (url.url)!) // Явное извлечения опционала плохая практика
        request.httpMethod = "POST"
        request.httpBody = json
        
        let session = URLSession(configuration: .ephemeral)
        session.dataTask(with: request) { (data, response, error) in
//            guard let data = data else { return }
        }.resume()
    }
    
    func sendMessage(with text: String, to chatId: Int64) throws {
        let message = NewMessageBody(with: text)
        let json = try JSONEncoder().encode(message)
        
        guard var url = URLComponents(string: urlMessage) else { return }
        var items: [URLQueryItem] = []
        let parameters = ["access_token" : token, "chat_id": String(chatId)]
        for (key, value) in parameters {
            items.append(URLQueryItem(name: key, value: value))
        }
        url.queryItems = items
        var request = URLRequest(url: (url.url)!) // Явное извлечения опционала плохая практика
        request.httpMethod = "POST"
        request.httpBody = json
        
        let session = URLSession(configuration: .ephemeral)
        session.dataTask(with: request) { (data, response, error) in
//            guard let data = data else { return }
        }.resume()
    }
    
//    func sendKeyboard
}
