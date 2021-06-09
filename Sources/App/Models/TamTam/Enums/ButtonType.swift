//
//  ButtonType.swift
//  
//
//  Created by Red Beard on 20.05.2021.
//

enum ButtonType: String, Codable {
    case callback
    case link
    case requestContact = "request_contact"
    case requestGeoLocation = "request_geo_location"
    case chat
}
