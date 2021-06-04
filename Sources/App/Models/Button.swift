//
//  Button.swift
//  
//
//  Created by Red Beard on 20.05.2021.
//

class Button: Codable {
    let type: ButtonType
    let text: String
    let payload: String
    let intent: IntentButton?
    
    init(type: ButtonType, text: String, payload: String, intent: IntentButton? = nil) {
        self.type = type
        self.text = text
        self.payload = payload
        self.intent = intent
    }
    
    // MARK: - JSON
    private enum CodingKeys: CodingKey {
        case type
        case text
        case payload
        case intent
    }
    
    func encode(to encoder: Encoder) throws {
        var container = encoder.container(keyedBy: CodingKeys.self)
        
        try container.encode(type, forKey: .type)
        try container.encode(text, forKey: .text)
        try container.encode(payload, forKey: .payload)
        if let intent = intent {
            try container.encode(intent, forKey: .intent)
        }
    }
    
    required init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        
        type = try container.decode(ButtonType.self, forKey: .type)
        text = try container.decode(String.self, forKey: .text)
        payload = try container.decode(String.self, forKey: .payload)
        intent = try? container.decode(IntentButton.self, forKey: .intent)
    }
}
