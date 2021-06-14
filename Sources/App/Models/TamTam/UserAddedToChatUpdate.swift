//
//  UserAddedToChatUpdate.swift
//
//
//  Created by Red Beard on 21.05.2021.
//

class UserAddedToChatUpdate: Update {
    let chatId: Int64
    let user: User
    let inviterId: Int64?
    let isChannel: Bool
    
    init(timestamp: Int64, chatId: Int64, user: User, inviterId: Int64? = nil, isChannel: Bool) {
        self.chatId = chatId
        self.user = user
        self.inviterId = inviterId
        self.isChannel = isChannel
        super.init(updateType: .userAdded, timestamp: timestamp)
    }
    
    // MARK: - JSON
    
    private enum CodingKeys: String, CodingKey {
        case timestamp
        case chatId = "chat_id"
        case user
        case inviterId = "inviter_id"
        case isChannel = "is_channel"
    }
    
    required init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        
        chatId = try container.decode(Int64.self, forKey: .chatId)
        user = try container.decode(User.self, forKey: .user)
        inviterId = try? container.decode(Int64.self, forKey: .inviterId)
        isChannel = try container.decode(Bool.self, forKey: .isChannel)
        try super.init(from: decoder)
    }
}
