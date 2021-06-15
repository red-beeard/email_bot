//
//  MessageHistoryId.swift
//  
//
//  Created by Red Beard on 15.06.2021.
//

import Foundation

class MessageHistoryId: Decodable {
    let messageId: String
    
    // MARK: - JSON
    private enum CodingKeys: CodingKey {
        case history
    }
    
    private struct History: Decodable {
        let id: String
        let messages: Message
    }
    
    private struct Message: Decodable {
        let id: String
        let threadId: String
    }
    
    required init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        let history = try container.decode([History].self, forKey: .history)
        history.max { $0.id < $1.id }
        messageId = "none"
    }
}
