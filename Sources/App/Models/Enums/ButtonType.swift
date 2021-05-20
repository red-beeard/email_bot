//
//  ButtonType.swift
//  
//
//  Created by Red Beard on 20.05.2021.
//

enum ButtonType: String, Codable {
    case callback = "callback"
    case link = "link"
    case request_contact = "request_contact"
    case request_geo_location = "request_geo_location"
    case chat = "chat"
}
