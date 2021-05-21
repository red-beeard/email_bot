//
//  Message.swift
//  
//
//  Created by Red Beard on 21.05.2021.
//

class Message: Codable {
    let sender: User
    let recipient: Recipient
    let timestamp: Int64
    let link: LinkedMessage?
    let body: MessageBody
    let stat: MessageStat?
    let url: String?
    let constructor: User?
}
