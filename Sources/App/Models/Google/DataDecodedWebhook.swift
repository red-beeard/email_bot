//
//  DataDecodedWebhook.swift
//  
//
//  Created by Red Beard on 15.06.2021.
//

class DataDecodedWebhook: Codable {
    let emailAddress: String
    let historyId: Int64
    
    // MARK: - JSON
    required init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)

        emailAddress = try container.decode(String.self, forKey: .emailAddress)
        historyId = try container.decode(Int64.self, forKey: .historyId)
    }
}
