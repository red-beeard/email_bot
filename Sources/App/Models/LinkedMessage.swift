//
//  LinkedMessage.swift
//  
//
//  Created by Red Beard on 21.05.2021.
//

class LinkedMessage: Codable {
    let type: MessageLinkType
    let sender: User
    let chatId: Int64
    let message: MessageBody
    
    // MARK: - JSON
    
    private enum CodingKeys: String, CodingKey {
        case type
        case sender
        case chatId = "chat_id"
        case message
    }
    
    required init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        
        type = try container.decode(MessageLinkType.self, forKey: .type)
        sender = try container.decode(User.self, forKey: .sender)
        chatId = try container.decode(Int64.self, forKey: .chatId)
        message = try container.decode(MessageBody.self, forKey: .message)
    }
}
