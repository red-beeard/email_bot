//
//  User.swift
//  
//
//  Created by Red Beard on 21.05.2021.
//

class User: Codable {
    let user_id: Int64
    let name: String
    let username: String?
    let is_bot: Bool
//    let lastActivityTime: Int64
}
