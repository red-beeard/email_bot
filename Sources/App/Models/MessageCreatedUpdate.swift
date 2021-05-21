//
//  MessageCreatedUpdate.swift
//  
//
//  Created by Red Beard on 21.05.2021.
//

class MessageCreatedUpdate: Update {
    let message: Message
    let userLocale: String?
    
    init(updateType: UpdateType, timestamp: Int64, message: Message, userLocale: String?) {
        self.message = message
        self.userLocale = userLocale
        super.init(updateType: updateType, timestamp: timestamp)
    }
    
    required init(from decoder: Decoder) throws {
        fatalError("init(from:) has not been implemented")
    }
}
