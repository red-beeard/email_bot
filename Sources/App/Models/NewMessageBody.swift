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
    
    init(with text: String? = nil, with attachments: [AttachmentRequest]? = nil, with link: NewMessageLink? = nil) {
        self.text = text
        self.attachments = attachments
        self.link = link
    }
    
    func setNotify(_ notify: Bool) {
        self.notify = notify
    }
    
    // MARK: - URL
    private enum CodingKeys: CodingKey {
        case text
        case attachments
        case link
        case notify
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
    }
}
