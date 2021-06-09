//
//  Button.swift
//  
//
//  Created by Red Beard on 20.05.2021.
//

class Button: Codable {
    let type: ButtonType
    let text: String
    
    init(type: ButtonType, text: String) {
        self.type = type
        self.text = text
    }
    
    // MARK: - JSON
    private enum CodingKeys: CodingKey {
        case type
        case text
    }
    
    func encode(to encoder: Encoder) throws {
        var container = encoder.container(keyedBy: CodingKeys.self)
        
        try container.encode(type, forKey: .type)
        try container.encode(text, forKey: .text)
    }
    
    required init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        
        type = try container.decode(ButtonType.self, forKey: .type)
        text = try container.decode(String.self, forKey: .text)
    }
}
