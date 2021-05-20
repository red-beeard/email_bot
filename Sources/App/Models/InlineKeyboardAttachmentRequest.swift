//
//  InlineKeyboardAttachmentRequest.swift
//  
//
//  Created by Red Beard on 20.05.2021.
//

class InlineKeyboardAttachmentRequest: AttachmentRequest {
    var payload: InlineKeyboardAttachmentRequestPayload
    
    init(type: AttachmentType, payload: InlineKeyboardAttachmentRequestPayload) {
        self.payload = payload
        super.init(type: type)
    }
    
    required init(from decoder: Decoder) throws {
        fatalError("init(from:) has not been implemented")
    }
}
