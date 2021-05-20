//
//  AttachmentType.swift
//  
//
//  Created by Red Beard on 20.05.2021.
//

enum AttachmentType: String, Codable {
    case image = "image"
    case video = "video"
    case audio = "audio"
    case file = "file"
    case contact = "contact"
    case sticker = "sticker"
    case inline_keyboard = "inline_keyboard"
}
