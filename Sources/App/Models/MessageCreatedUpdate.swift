//
//  MessageCreatedUpdate.swift
//  
//
//  Created by Red Beard on 21.05.2021.
//

class MessageCreatedUpdate: Update {
    let message: Message
    let userLocale: String?
    
    init(updateType: UpdateType, timestamp: Int64, message: Message, userLocale: String?) {
        self.message = message
        self.userLocale = userLocale
        super.init(updateType: updateType, timestamp: timestamp)
    }
    
    // MARK: - Description
    func description() -> String {
        return """
            message: \(message.description())
            userLocale: \(userLocale ?? "nil")
            """
    }
    
    // MARK: - JSON
    
    private enum CodingKeys: String, CodingKey {
        case updateType = "update_type"
        case timestamp
        case message
        case userLocale = "user_locale"
    }
    
    required init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        
        message = try container.decode(Message.self, forKey: .message)
        userLocale = try? container.decode(String.self, forKey: .userLocale)
        try super.init(from: decoder)
    }
}
