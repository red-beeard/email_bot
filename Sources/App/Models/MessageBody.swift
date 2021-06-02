//
//  MessageBody.swift
//  
//
//  Created by Red Beard on 21.05.2021.
//

class MessageBody: Codable {
    let mid: String
    let seq: Int64
    let text: String?
    let attachments: [Attachment]
//    let markup: [Markup]
}
