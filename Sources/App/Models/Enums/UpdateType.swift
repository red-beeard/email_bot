//
//  UpdateType.swift
//  
//
//  Created by Red Beard on 20.05.2021.
//

enum UpdateType: String, Codable {
    case message_callback = "message_callback"
    case message_created = "message_created"
    case message_removed = "message_removed"
    case message_edited = "message_edited"
    case bot_added = "bot_added"
    case bot_removed = "bot_removed"
    case user_added = "user_added"
    case user_removed = "user_removed"
    case bot_started = "bot_started"
    case chat_title_changed = "chat_title_changed"
    case message_constructed_request = "message_construction_request"
    case message_constructed = "message_constructed"
    case message_chat_created = "message_chat_created"
}
