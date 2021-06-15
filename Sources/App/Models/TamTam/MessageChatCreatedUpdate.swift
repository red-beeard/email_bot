//
//  MessageChatCreatedUpdate.swift
//  
//
//  Created by Red Beard on 15.06.2021.
//

class MessageChatCreatedUpdate: Update {
    let chat: Chat
    let messageId: String
    let startPayload: String?
    
    init(timestamp: Int64, chat: Chat, messageId: String, startPayload: String? = nil) {
        self.chat = chat
        self.messageId = messageId
        self.startPayload = startPayload
        super.init(updateType: .messageChatCreated, timestamp: timestamp)
    }
    
    // MARK: - JSON
    
    private enum CodingKeys: String, CodingKey {
        case timestamp
        case chat
        case messageId = "message_id"
        case startPayload = "start_payload"
    }
    
    required init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        
        chat = try container.decode(Chat.self, forKey: .chat)
        messageId = try container.decode(String.self, forKey: .messageId)
        startPayload = try? container.decode(String.self, forKey: .startPayload)
        try super.init(from: decoder)
    }
}

