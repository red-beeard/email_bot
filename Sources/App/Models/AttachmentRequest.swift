//
//  AttachmentRequest.swift
//  
//
//  Created by Red Beard on 20.05.2021.
//

class AttachmentRequest: Codable {
    let type: AttachmentType
    
    init(type: AttachmentType) {
        self.type = type
    }
}
