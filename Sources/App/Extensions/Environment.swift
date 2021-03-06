//
//  Environment.swift
//  
//
//  Created by Red Beard on 09.06.2021.
//

import Vapor

extension Environment {
    static let tamTamToken = Self.get("TAMTAM_TOKEN")!
    
    static let googleClientId = Self.get("GOOGLE_CLIENT_ID")!
    static let googleProjectId = Self.get("GOOGLE_PROJECT_ID")!
    static let googleClientSecret = Self.get("GOOGLE_CLIENT_SECRET")!
    
    static let usernameDatabase = Self.get("USERNAME_DATABASE")!
    static let passwordDatabase = Self.get("PASSWORD_DATABASE")!
    static let database = Self.get("DATABASE")!
}
