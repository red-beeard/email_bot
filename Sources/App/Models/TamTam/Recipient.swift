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
    
    // MARK: - JSON
    
    private enum CodingKeys: String, CodingKey {
        case chatId = "chat_id"
        case chatType = "chat_type"
        case userId = "user_id"
    }
    
    required init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        
        chatId = try? container.decode(Int64.self, forKey: .chatId)
        chatType = try container.decode(ChatType.self, forKey: .chatType)
        userId = try? container.decode(Int64.self, forKey: .userId)
    }
}
