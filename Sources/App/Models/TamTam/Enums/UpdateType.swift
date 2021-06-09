//
//  UpdateType.swift
//  
//
//  Created by Red Beard on 20.05.2021.
//

enum UpdateType: String, Codable {
    case messageCallback = "message_callback"
    case messageCreated = "message_created"
    case messageRemoved = "message_removed"
    case messageEdited = "message_edited"
    case botAdded = "bot_added"
    case botRemoved = "bot_removed"
    case userAdded = "user_added"
    case userRemoved = "user_removed"
    case botStarted = "bot_started"
    case chatTitleChanged = "chat_title_changed"
    case messageConstructedRequest = "message_construction_request"
    case messageConstructed = "message_constructed"
    case messageChatCreated = "message_chat_created"
}
