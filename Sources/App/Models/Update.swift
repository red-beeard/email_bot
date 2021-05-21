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
}
