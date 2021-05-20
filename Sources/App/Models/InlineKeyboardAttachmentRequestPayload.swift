//
//  InlineKeyboardAttachmentRequestPayload.swift
//  
//
//  Created by Red Beard on 20.05.2021.
//

class InlineKeyboardAttachmentRequestPayload {
    let buttons: [[Button]]
    
    init(buttons: [[Button]]) {
        self.buttons = buttons
    }
}
