//
//  CallbackButton.swift
//
//
//  Created by Red Beard on 04.06.2021.
//

class CallbackButton: Button {
    let payload: String
    let intent: IntentButton
    
    init(text: String, payload: String, intent: IntentButton) {
        self.payload = payload
        self.intent = intent
        super.init(type: .callback, text: text)
    }
    
    // MARK: - JSON
    private enum CodingKeys: CodingKey {
        case type
        case text
        case payload
        case intent
    }
    
    override func encode(to encoder: Encoder) throws {
        var container = encoder.container(keyedBy: CodingKeys.self)
        
        try container.encode(type, forKey: .type)
        try container.encode(text, forKey: .text)
        try container.encode(payload, forKey: .payload)
        try container.encode(intent, forKey: .intent)
    }
    
    required init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        
        payload = try container.decode(String.self, forKey: .payload)
        intent = try container.decode(IntentButton.self, forKey: .intent)
        try super.init(from: decoder)
    }
}
