//
//  ProfileResponse.swift
//  
//
//  Created by Red Beard on 11.06.2021.
//

class ProfileResponse: Codable {
    let emailAddress: String
    let messagesTotal: Int
    let threadsTotal: Int
    let historyId: String


    // MARK: - JSON
    required init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)

        emailAddress = try container.decode(String.self, forKey: .emailAddress)
        messagesTotal = try container.decode(Int.self, forKey: .messagesTotal)
        threadsTotal = try container.decode(Int.self, forKey: .threadsTotal)
        historyId = try container.decode(String.self, forKey: .historyId)
    }
}
