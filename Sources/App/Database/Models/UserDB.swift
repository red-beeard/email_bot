//
// Created by konstantin on 14.06.2021.
//

import Foundation

class UserDB: Codable {
    let idInDB: Int
    let userId: Int
    let accessToken: String
    let refreshToken: String
    let email: String
    let chatId: Int?


    // MARK: - JSON
    private enum CodingKeys: String, CodingKey {
        case idInDB = "ID"
        case userId = "user_id"
        case accessToken = "access_token"
        case refreshToken = "refresh_token"
        case email = "email_address"
        case chatId = "chat_id"
    }

    required init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)

        idInDB = try container.decode(Int.self, forKey: .idInDB)
        accessToken = try container.decode(String.self, forKey: .accessToken)
        userId = try container.decode(Int.self, forKey: .userId)
        email = try container.decode(String.self, forKey: .email)
        chatId = try? container.decode(Int.self, forKey: .chatId)
        refreshToken = try container.decode(String.self, forKey: .refreshToken)
    }
}
