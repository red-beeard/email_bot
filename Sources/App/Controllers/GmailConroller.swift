//
//  GmailConroller.swift
//  
//
//  Created by Red Beard on 08.06.2021.
//

import Vapor

class GmailController {
    private let topicName = "projects/crested-archive-309914/topics/TamTamEmail"
    private let watchUri = "https://gmail.googleapis.com/gmail/v1/users/me/watch"
    
    
    func handleWebHook(req: Request) throws -> HTTPResponseStatus {
        print(req.description)
        print(req.body.string ?? "Ничего")
        return HTTPStatus.ok
    }
    
    func watch(by accessToken: String) {
        guard let url = URL(string: watchUri) else { return }
        var request = URLRequest(url: url)
        request.httpMethod = "POST"
        request.setValue("application/json", forHTTPHeaderField: "Content-Type")
        request.setValue("Bearer \(accessToken)", forHTTPHeaderField: "Authorization")
        request.httpBody = try? JSONEncoder().encode(WatchRequest(topicName: topicName, labelIds: ["INBOX"]))
        
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
