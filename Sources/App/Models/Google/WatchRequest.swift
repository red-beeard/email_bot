//
//  WatchRequest.swift
//  
//
//  Created by Red Beard on 11.06.2021.
//

class WatchRequest: Codable {
    let topicName: String
    let labelIds: [String]
    let labelFilterAction: LabelFilterAction
    
    init(topicName: String, labelIds: [String], labelFilterAction: LabelFilterAction) {
        self.topicName = topicName
        self.labelIds = labelIds
        self.labelFilterAction = labelFilterAction
    }
}
