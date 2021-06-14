//
//  ChatButton.swift
//  
//
//  Created by Red Beard on 04.06.2021.
//

class ChatButton: Button {
    let chatTitle: String
    let chatDescription: String?
    let startPayload: String?
    let uuid: Int?
    
    init(text: String, chatTitle: String, chatDescription: String? = nil, startPayload: String? = nil, uuid: Int? = nil) {
        self.chatTitle = chatTitle
        self.chatDescription = chatDescription
        self.startPayload = startPayload
        self.uuid = uuid
        super.init(type: .chat, text: text)
    }
    
    // MARK: - JSON
    private enum CodingKeys: String, CodingKey {
        case type
        case text
        case chatTitle = "chat_title"
        case chatDescription = "chat_description"
        case startPayload = "start_payload"
        case uuid
    }
    
    override func encode(to encoder: Encoder) throws {
        var container = encoder.container(keyedBy: CodingKeys.self)
        
        try container.encode(type, forKey: .type)
        try container.encode(text, forKey: .text)
        try container.encode(chatTitle, forKey: .chatTitle)
        if let chatDescription = chatDescription {
            try container.encode(chatDescription, forKey: .chatDescription)
        }
        
        if let startPayload = startPayload {
            try container.encode(startPayload, forKey: .startPayload)
        }
        
        if let uuid = uuid {
            try container.encode(uuid, forKey: .uuid)
        }
    }
    
    required init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        
        chatTitle = try container.decode(String.self, forKey: .chatTitle)
        chatDescription = try? container.decode(String.self, forKey: .chatDescription)
        startPayload = try? container.decode(String.self, forKey: .startPayload)
        uuid = try? container.decode(Int.self, forKey: .uuid)
        try super.init(from: decoder)
    }
}
