//
//  MessageStat.swift
//  
//
//  Created by Red Beard on 21.05.2021.
//

class MessageStat: Codable {
    let views: Int
    
    // MARK: - JSON
    
    private enum CodingKeys: CodingKey {
        case views
    }
    
    required init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        
        views = try container.decode(Int.self, forKey: .views)
    }
}
