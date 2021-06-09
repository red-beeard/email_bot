//
//  Attachment.swift
//  
//
//  Created by Red Beard on 21.05.2021.
//

class Attachment: Codable {
    let type: AttachmentType
    
    // MARK: - JSON
    
    private enum CodingKeys: CodingKey {
        case type
    }
    
    required init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        
        type = try container.decode(AttachmentType.self, forKey: .type)
    }
}
