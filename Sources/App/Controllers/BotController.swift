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
    private class ErrorApiTamtam: Decodable {
        let code: String
        let message: String
        
        private enum ErrorApi: CodingKey {
            case code
            case message
        }
        
        required init(from decoder: Decoder) throws {
            let container = try decoder.container(keyedBy: ErrorApi.self)
            code = try container.decode(String.self, forKey: .code)
            message = try container.decode(String.self, forKey: .message)
        }
    }
    
    private let token = "vlIHSMAYdD4N3V_1LHKeeFJS9a9mJ7vu2eg6VLXzVWA"
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
            try sendKeyboard(to: chatId, and: update.message.sender.userId)
        } else {
            try sendMessage(with: dontUnderstandMessage, to: chatId)
        }
    }
    
    private func getKeyboard(for userId: Int64) -> InlineKeyboardAttachmentRequest {
        let buttons = [[LinkButton(text: "Google", url: GoogleAuthController().getUrlForAuth(for: userId))]]
        let keyboardPayload = InlineKeyboardAttachmentRequestPayload(buttons: buttons)
        let keyboard = InlineKeyboardAttachmentRequest(payload: keyboardPayload)
        return keyboard
    }
    
    private func sendKeyboard(to chatId: Int64, and userId: Int64) throws {
        let keyboard = getKeyboard(for: userId)
        let message = NewMessageBody(with: "Select service:", with: [keyboard])
        let json = try JSONEncoder().encode(message)
        
        guard var url = URLComponents(string: urlMessage) else { return }
        var items: [URLQueryItem] = []
        let parameters = ["access_token" : token, "chat_id": String(chatId)]
        for (key, value) in parameters {
            items.append(URLQueryItem(name: key, value: value))
        }
        url.queryItems = items
        var request = URLRequest(url: (url.url)!)
        // Явное извлечения опционала плохая практика
        request.httpMethod = "POST"
        request.httpBody = json
        
        print("\nОтправляемый запрос:")
        print(String(data: json, encoding: .utf8) ?? "Не распечатал")
        print("\n")
        
        let session = URLSession(configuration: .ephemeral)
        session.dataTask(with: request) { (data, response, error) in
            if let data = data {
                let responseData = try! JSONDecoder().decode(ErrorApiTamtam.self, from: data)
                print("code: \(responseData.code)")
                print("message: \(responseData.message)")
            }
            if let response = response {
                let httpResponse = response as! HTTPURLResponse
                print("response code = \(httpResponse.statusCode)")
            }
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
        session.dataTask(with: request).resume()
    }
}
