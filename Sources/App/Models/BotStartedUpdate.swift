//
//  BotStartedUpdate.swift
//  
//
//  Created by Red Beard on 04.06.2021.
//

class BotStartedUpdate: Update {
    let chatId: Int64
    let user: User
    let payload: String?
    let userLocale: String?
    
    // MARK: - JSON
    
    private enum CodingKeys: String, CodingKey {
        case chatId = "chat_id"
        case user
        case payload
        case userLocale = "user_locale"
    }
    
    required init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        
        chatId = try container.decode(Int64.self, forKey: .chatId)
        user = try container.decode(User.self, forKey: .payload)
        payload = try? container.decode(String.self, forKey: .payload)
        userLocale = try? container.decode(String.self, forKey: .userLocale)
        try super.init(from: decoder)
    }
}
