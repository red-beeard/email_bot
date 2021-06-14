//
//  GoogleDatabaseModel.swift
//  
//
//  Created by Red Beard on 14.06.2021.
//

import Vapor
import Fluent
import FluentPostgresDriver

final class GoogleDatabaseModel: Model, Content {
    static let schema = "google_email"

    @ID(custom: "ID")
    var id: Int?

    @Field(key: "user_id")
    var userId: Int64
    
    @Field(key: "chat_id")
    var chatId: Int64?
    
    @Field(key: "access_token")
    var accessToken: String
    
    @Field(key: "refresh_token")
    var refreshToken: String
    
    @Field(key: "email_address")
    var emailAddress: String
    
    init() { }

    init(id: Int? = nil, userId: Int64, chatId: Int64? = nil, accessToken: String, refreshToken: String, emailAddress: String) {
        self.id = id
        self.userId = userId
        self.chatId = chatId
        self.accessToken = accessToken
        self.refreshToken = refreshToken
        self.emailAddress = emailAddress
    }
}
