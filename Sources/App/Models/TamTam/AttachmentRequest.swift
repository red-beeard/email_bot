//
//  AttachmentRequest.swift
//  
//
//  Created by Red Beard on 20.05.2021.
//

class AttachmentRequest: Codable {
    let type: AttachmentType
    
    init(type: AttachmentType) {
        self.type = type
    }
    
    private enum CodingKeys: CodingKey {
        case type
    }
    
    func encode(to encoder: Encoder) throws {
        var container = encoder.container(keyedBy: CodingKeys.self)
        try container.encode(type, forKey: .type)
    }
}
