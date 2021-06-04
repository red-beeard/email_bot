//
//  Message.swift
//  
//
//  Created by Red Beard on 21.05.2021.
//

class Message: Codable {
    let sender: User
    let recipient: Recipient
    let timestamp: Int64
    let link: LinkedMessage?
    let body: MessageBody
    let stat: MessageStat?
    let url: String?
    let constructor: User?

    // MARK: - JSON
    
    private enum CodingKeys: CodingKey {
        case sender
        case recipient
        case timestamp
        case link
        case body
        case stat
        case url
        case constructor
    }
    
    required init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        
        sender = try container.decode(User.self, forKey: .sender)
        recipient = try container.decode(Recipient.self, forKey: .recipient)
        timestamp = try container.decode(Int64.self, forKey: .timestamp)
        link = try? container.decode(LinkedMessage.self, forKey: .link)
        body = try container.decode(MessageBody.self, forKey: .body)
        stat = try? container.decode(MessageStat.self, forKey: .stat)
        url = try? container.decode(String.self, forKey: .url)
        constructor = try? container.decode(User.self, forKey: .constructor)
    }
}
