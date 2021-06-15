//
//  Chat.swift
//  
//
//  Created by Red Beard on 15.06.2021.
//

class Chat: Codable {
    let chatId: Int64
    let type: ChatType
//    let status: ChatStatus
    let title: String?
//    let icon: Image?
    let lastEventTime: Int64
    let participantsCount: Int
    let ownerId: Int64?
//    let participants: [String : Int64]?
    let isPublic: Bool
    let link: String?
    let description: String?
//    let dialogWithUser: UserWithPhoto?
    let messageCount: Int?
    let chatMessageId: String?
    let pinnedMessage: Message?
    
    // MARK: - JSON
    
    private enum CodingKeys: String, CodingKey {
        case chatId = "chat_id"
        case type
        case title
        case lastEventTime = "last_event_time"
        case participantsCount = "participants_count"
        case ownerId = "owner_id"
        case isPublic = "is_public"
        case link
        case description
        case messageCount = "message_count"
        case chatMessageId = "chat_message_id"
        case pinnedMessage = "pinned_message"
    }
    
    required init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        
        chatId = try container.decode(Int64.self, forKey: .chatId)
        type = try container.decode(ChatType.self, forKey: .type)
        title = try? container.decode(String.self, forKey: .title)
        lastEventTime = try container.decode(Int64.self, forKey: .lastEventTime)
        participantsCount = try container.decode(Int.self, forKey: .participantsCount)
        ownerId = try? container.decode(Int64.self, forKey: .ownerId)
        isPublic = try container.decode(Bool.self, forKey: .isPublic)
        link = try? container.decode(String.self, forKey: .link)
        description = try? container.decode(String.self, forKey: .description)
        messageCount = try? container.decode(Int.self, forKey: .messageCount)
        chatMessageId = try? container.decode(String.self, forKey: .chatMessageId)
        pinnedMessage = try? container.decode(Message.self, forKey: .pinnedMessage)
    }
}
