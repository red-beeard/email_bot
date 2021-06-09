//
//  AttachmentType.swift
//  
//
//  Created by Red Beard on 20.05.2021.
//

enum AttachmentType: String, Codable {
    case image
    case video
    case audio
    case file
    case contact
    case sticker
    case inlineKeyboard = "inline_keyboard"
    case location
    case share
}
