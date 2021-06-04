//
//  NewMessageBody.swift
//  
//
//  Created by Red Beard on 20.05.2021.
//

class NewMessageBody: Codable {
    let text: String?
    let attachments: [AttachmentRequest]?
    let link: NewMessageLink?
    var notify = true
    var format: TextFormat? = nil
    
    init(with text: String?, with attachments: [AttachmentRequest]?, with link: NewMessageLink?) {
        self.text = text
        self.attachments = attachments
        self.link = link
    }
    
    func setNotify(_ notify: Bool) {
        self.notify = notify
    }
    
    private enum CodingKeys: CodingKey {
        case text
        case attachments
        case link
        case notify
        case format
    }
    
    func encode(to encoder: Encoder) throws {
        var container = encoder.container(keyedBy: CodingKeys.self)
        if let text = text {
            try container.encode(text, forKey: .text)
        }
        
        if let attachments = attachments {
            try container.encode(attachments, forKey: .attachments)
        }
        
        if let link = link {
            try container.encode(link, forKey: .link)
        }

        try container.encode(notify, forKey: .notify)
        
        if let format = format {
            try container.encode(format, forKey: .format)
        }
    }
}
