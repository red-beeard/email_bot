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
//        print(req.body.string)
//        print(req)
        
//        if webHookType == UpdateType.bot_started.rawValue {
//            return HTTPStatus.ok
//        } else if webHookType == UpdateType.message_created.rawValue {
//
//        } else {
//
//        }
        
        
        return HTTPStatus.ok
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
}
