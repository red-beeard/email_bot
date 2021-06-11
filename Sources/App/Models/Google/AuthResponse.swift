//
//  AuthResponse.swift
//  
//
//  Created by Red Beard on 10.06.2021.
//

class AuthResponse: Codable {
    let idToken: String
    let accessToken: String
    let tokenType: String
    let expiresIn: Int
    let scope: String
    let refreshToken: String?


    // MARK: - JSON
    private enum CodingKeys: String, CodingKey {
        case idToken = "id_token"
        case accessToken = "access_token"
        case tokenType = "token_type"
        case expiresIn = "expires_in"
        case scope
        case refreshToken = "refresh_token"
    }

    required init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)

        idToken = try container.decode(String.self, forKey: .idToken)
        accessToken = try container.decode(String.self, forKey: .accessToken)
        tokenType = try container.decode(String.self, forKey: .tokenType)
        expiresIn = try container.decode(Int.self, forKey: .expiresIn)
        scope = try container.decode(String.self, forKey: .scope)
        refreshToken = try? container.decode(String.self, forKey: .refreshToken)
    }
}
