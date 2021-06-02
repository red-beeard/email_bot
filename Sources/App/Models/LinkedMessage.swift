//
//  LinkedMessage.swift
//  
//
//  Created by Red Beard on 21.05.2021.
//

class LinkedMessage: Codable {
    let type: MessageLinkType
    let sender: User
    let chat_id: Int64
    let message: MessageBody
}
