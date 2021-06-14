//
//  GoogleDatabaseModel.swift
//  
//
//  Created by Red Beard on 14.06.2021.
//

import Vapor
import Fluent
import FluentPostgresDriver

final class GoogleDatabaseModel: Model {
    static let schema = "GOOGLE"

    @ID(key: .id)
    var id: UUID?

    @Field(key: "USER_ID")
    var userId: Int64?
    
    @Field(key: "USER_ID")
    var chatId: Int64?
    
    @Field(key: "ACCESS_TOKEN")
    var accessToken: String
    
    @Field(key: "REFRESH_TOKEN")
    var refreshToken: String
    
    @Field(key: "EMAIL_ADDRESS")
    var emailAddress: String
    
    @Field(key: "EXPIRES_IN")
    var expiresIn: Int
    
    init() { }

    init(id: UUID? = nil, userId: Int64? = nil, chatId: Int64? = nil, accessToken: String, refreshToken: String, emailAddress: String, expiresIn: Int) {
        self.id = id
        self.userId = userId
        self.chatId = chatId
        self.accessToken = accessToken
        self.refreshToken = refreshToken
        self.emailAddress = emailAddress
        self.expiresIn = expiresIn
    }
}
