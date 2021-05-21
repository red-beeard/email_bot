//
//  Recipient.swift
//  
//
//  Created by Red Beard on 21.05.2021.
//

class Recipient: Codable {
    let chatId: Int64?
    let chatType: ChatType
    let userId: Int64?
}
