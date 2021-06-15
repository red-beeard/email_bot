//
//  WatchWebhook.swift
//  
//
//  Created by Red Beard on 15.06.2021.
//

import Foundation

class WatchWebhook: Decodable {
    let subscription: String
    let data: DataDecodedWebhook
    let messageId: String
    let publishTime: String
    
    // MARK: - JSON
    private enum CodingKeys: CodingKey {
        case message
        case subscription
    }
    
    private enum NestedCodingKeys: CodingKey {
        case data
        case messageId
        case publishTime
    }
    
    required init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)

        subscription = try container.decode(String.self, forKey: .subscription)
        let message = try container.nestedContainer(keyedBy: NestedCodingKeys.self, forKey: .message)
        
        let dataInString = try message.decode(String.self, forKey: .data)
        let dataInJSON = Data(base64Encoded: dataInString)!
        data = try! JSONDecoder().decode(DataDecodedWebhook.self, from: dataInJSON)
        messageId = try message.decode(String.self, forKey: .messageId)
        publishTime = try message.decode(String.self, forKey: .publishTime)
    }
}
