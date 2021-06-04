//
//  Update.swift
//  
//
//  Created by Red Beard on 21.05.2021.
//

class Update: Codable {
    let updateType: UpdateType
    let timestamp: Int64
    
    init(updateType: UpdateType, timestamp: Int64) {
        self.updateType = updateType
        self.timestamp = timestamp
    }
    
    // MARK: - JSON
    
    private enum CodingKeys: String, CodingKey {
        case updateType = "update_type"
        case timestamp
    }
    
    required init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        
        updateType = try container.decode(UpdateType.self, forKey: .updateType)
        timestamp = try container.decode(Int64.self, forKey: .timestamp)
    }
}
