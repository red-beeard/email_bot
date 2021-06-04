//
//  User.swift
//  
//
//  Created by Red Beard on 21.05.2021.
//

class User: Codable {
    let userId: Int64
    let name: String
    let username: String?
    let isBot: Bool
    let lastActivityTime: Int64
    
    // MARK: - JSON
    
    private enum CodingKeys: String, CodingKey {
        case userId = "user_id"
        case name
        case username
        case isBot = "is_bot"
        case lastActivityTime = "last_activity_time"
    }
    
    required init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        
        userId = try container.decode(Int64.self, forKey: .userId)
        name = try container.decode(String.self, forKey: .name)
        username = try? container.decode(String.self, forKey: .username)
        isBot = try container.decode(Bool.self, forKey: .isBot)
        lastActivityTime = try container.decode(Int64.self, forKey: .lastActivityTime)
    }
}
