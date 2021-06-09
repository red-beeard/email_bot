//
//  MessageBody.swift
//  
//
//  Created by Red Beard on 21.05.2021.
//

class MessageBody: Codable {
    let mid: String
    let seq: Int64
    let text: String?
    let attachments: [Attachment]?
//    let markup: [MarkupElement]?
//    Поле для форматирования текста
//    Возможно добавление после. В документации нет
    
    // MARK: - JSON
    
    private enum CodingKeys: CodingKey {
        case mid
        case seq
        case text
        case attachments
    }
    
    required init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        
        mid = try container.decode(String.self, forKey: .mid)
        seq = try container.decode(Int64.self, forKey: .seq)
        text = try? container.decode(String.self, forKey: .text)
        attachments = try? container.decode([Attachment].self, forKey: .attachments)
    }
}
