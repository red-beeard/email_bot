//
//  GmailConroller.swift
//  
//
//  Created by Red Beard on 08.06.2021.
//

import Vapor
import Fluent
import FluentPostgresDriver
#if canImport(FoundationNetworking)
import FoundationNetworking
#endif

class GmailController {
    private let topicName = "projects/crested-archive-309914/topics/TamTamEmail"
    private let watchUri = "https://gmail.googleapis.com/gmail/v1/users/me/watch"
    private let historyUri = "https://gmail.googleapis.com/gmail/v1/users/me/history"
    
    
    func handleWebHook(req: Request) throws -> HTTPResponseStatus {
//        print(req.description)
        print(req.body.string ?? "Ничего")
        
        let webHook = try req.content.decode(WatchWebhook.self)
        print("Email: \(webHook.data.emailAddress)")
        print("HistoryID: \(webHook.data.historyId)\n")
        
        GoogleDatabaseModel.query(on: req.db)
            .filter(\.$emailAddress == webHook.data.emailAddress)
            .first()
            .whenSuccess { record in
                guard let record = record else { return }
                
                let response = req.client.get(URI(string: self.historyUri)) { req in
                    try req.query.encode(["startHistoryId" : webHook.data.historyId])
                    req.headers.add(name: "Authorization", value: "Bearer \(record.$accessToken)")
                }.map { res in
                    try? res.content.decode(MessageHistoryId.self)
                }
                
                response.whenSuccess { message in
                    guard let message = message else {
                        print("Message is nil")
                        return
                    }
                    print(message.messageId)
                }
            }
        
        
        
        return HTTPStatus.ok
    }
    
    func watch(by accessToken: String) {
        guard let url = URL(string: watchUri) else { return }
        var request = URLRequest(url: url)
        request.httpMethod = "POST"
        request.setValue("application/json", forHTTPHeaderField: "Content-Type")
        request.setValue("Bearer \(accessToken)", forHTTPHeaderField: "Authorization")
        request.httpBody = try? JSONEncoder().encode(WatchRequest(topicName: topicName, labelIds: ["INBOX"]))
//        , labelFilterAction: .include
        
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
