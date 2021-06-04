//
//  BotController.swift
//  
//
//  Created by Red Beard on 20.05.2021.
//

import Vapor

class BotController {
    private let token = "vlIHSMAYdD4N3V_1LHKeeFJS9a9mJ7vu2eg6VLXzVWA"
    private let urlMessage = "https://botapi.tamtam.chat/messages"
    
    func handleWebHook(req: Request) throws -> HTTPResponseStatus {
        guard let webHookType: String = req.content["update_type"] else { return HTTPStatus.ok }
        print(webHookType)
        
        try sendKeyboard(to: 6296683952)
        
        return HTTPStatus.ok
    }
    
    func getKeyboard() -> InlineKeyboardAttachmentRequest {
        let buttons = [[Button(type: .callback, text: "Google", payload: "GoogleAuth", intent: nil)]]
        let keyboardPayload = InlineKeyboardAttachmentRequestPayload(buttons: buttons)
        let keyboard = InlineKeyboardAttachmentRequest(
            type: .inline_keyboard,
            payload: keyboardPayload
        )
        return keyboard
    }
    
    func sendKeyboard(to chatId: Int64) throws {
        let keyboard = [getKeyboard()]
        let message = NewMessageBody(with: "Выберите сервис", with: keyboard, with: nil)
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
            if let response = response {
                print(response)
            }

            guard let data = data else { return }
            print(data)
        }.resume()
        
    }
    
    func sendMessage(with text: String, to chatId: Int64) {
//        guard var url = URLComponents(string: urlMessage) else { return }
//        var items: [URLQueryItem] = []
//        let parameters = ["access_token" : token]
//        for (key, value) in parameters {
//            items.append(URLQueryItem(name: key, value: value))
//        }
//        url.queryItems = items
//        let request = URLRequest(url: (url.url)!)
//
//        let session = URLSession(configuration: .ephemeral)
//        session.dataTask(with: request) { (data, response, error) in
//            if let response = response {
//                print(response)
//            }
//
//            guard let data = data else { return }
//            print(data)
//        }.resume()
    }
    
//    func sendKeyboard
}
