//
//  Button.swift
//  
//
//  Created by Red Beard on 20.05.2021.
//

struct Button: Codable {
    let type: ButtonType
    let text: String
    let payload: String
    let intent: IntentButton?
}
