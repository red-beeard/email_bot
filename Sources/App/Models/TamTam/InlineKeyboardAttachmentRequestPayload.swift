//
//  InlineKeyboardAttachmentRequestPayload.swift
//  
//
//  Created by Red Beard on 20.05.2021.
//

class InlineKeyboardAttachmentRequestPayload: Codable {
    let buttons: [[Button]]
    
    init(buttons: [[Button]]) {
        self.buttons = buttons
    }
}
