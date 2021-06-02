//
//  NewMessageBody.swift
//  
//
//  Created by Red Beard on 20.05.2021.
//

class NewMessageBody: Codable {
    let text: String?
    let attachments: AttachmentRequest?
    let link: NewMessageLink?
    var notify = true
    var format: TextFormat? = nil
    
    init(with text: String?, with attachments: AttachmentRequest?, with link: NewMessageLink?) {
        self.text = text
        self.attachments = attachments
        self.link = link
    }
    
    func setNotify(_ notify: Bool) {
        self.notify = notify
    }
}
