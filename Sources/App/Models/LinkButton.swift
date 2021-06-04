//
//  LinkButton.swift
//
//
//  Created by Red Beard on 04.06.2021.
//

class LinkButton: Button {
    let url: String
    
    init(text: String, url: String) {
        self.url = url
        super.init(type: .link, text: text)
    }
    
    // MARK: - JSON
    private enum CodingKeys: CodingKey {
        case type
        case text
        case url
    }
    
    override func encode(to encoder: Encoder) throws {
        var container = encoder.container(keyedBy: CodingKeys.self)
        
        try container.encode(type, forKey: .type)
        try container.encode(text, forKey: .text)
        try container.encode(url, forKey: .url)
    }
    
    required init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        
        url = try container.decode(String.self, forKey: .url)
        try super.init(from: decoder)
    }
}
