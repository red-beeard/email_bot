//
//  GoogleAuthController.swift
//  
//
//  Created by Red Beard on 02.06.2021.
//

import Vapor
#if canImport(FoundationNetworking)
import FoundationNetworking
#endif

class GoogleAuthController {
    private let authUri = "https://accounts.google.com/o/oauth2/v2/auth"
    private let tokenUri = "https://oauth2.googleapis.com/token"
    private let profileUri = "https://gmail.googleapis.com/gmail/v1/users/me/profile"
    private let redirectUri = "https://ttmailbot.site/google.oauth2"
    
    private let alreadyLoggedMessage = """
        You are already logged in to Google. You will have to forget our app in the security settings.
        """
    
    func handleAuth(req: Request) throws -> HTTPResponseStatus {
        print(req.url.string)
        print("")
        
        guard let authCode: String = req.query["code"] else {
            print("auth_code не пришёл")
            return HTTPStatus.ok
        }
        guard let userId: String = req.query["state"] else {
            print("Отсутствует user_id (state)")
            return HTTPStatus.ok
        }
        
        print(authCode)
        print("")
        
        let futureAuthClient = self.getAuthClient(for: req, and: authCode)
        futureAuthClient.whenSuccess { client in
            print(client.accessToken)
//            if client.refreshToken == nil {
//                try? BotController().sendMessage(with: self.alreadyLoggedMessage, to: userId)
//            } else {
//
//            }
            let profileUser = self.getUserProfile(for: req, by: client.accessToken)
            profileUser.whenSuccess { profileUser in
                print(profileUser.emailAddress)
            }
        }
        
        
        return HTTPStatus.ok
    }
    
    func getAuthClient(for req: Request, and authCode: String) -> EventLoopFuture<AuthResponse> {
        let response = req.client.post(URI(string: tokenUri)) { req in
            try req.content.encode(
                [
                    "client_id": Environment.googleClientId,
                    "client_secret": Environment.googleClientSecret,
                    "grant_type": "authorization_code",
                    "redirect_uri": redirectUri,
                    "code": authCode,
                    "access_type": "offline",
                    "prompt": "consent"
                ]
            )
        }.flatMapThrowing { res in
            return try res.content.decode(AuthResponse.self)
        }
        return response
    }
    
    func getUserProfile(for req: Request, by accessToken: String) -> EventLoopFuture<ProfileResponse> {
        let response = req.client.get(URI(string: profileUri)) { req in
            req.headers.add(name: "Authorization", value: "Bearer \(accessToken)")
        }.flatMapThrowing { res -> ProfileResponse in
            print(res.status)
            return try res.content.decode(ProfileResponse.self)
        }
        return response
    }
    
    func getUrlForAuth(for userId: Int64) -> String {
        guard var url = URLComponents(string: authUri) else { return "" }
        var items: [URLQueryItem] = []
        let parameters = [
            "response_type" : "code",
            "scope": "email https://mail.google.com",
            "access_type": "offline",
            "client_id": Environment.googleClientId,
            "redirect_uri": redirectUri,
            "state": String(userId)
        ]
        for (key, value) in parameters {
            items.append(URLQueryItem(name: key, value: value))
        }
        url.queryItems = items
        
        print(url.string!)
        return url.string! // Явное извлечение опционалов плохая практика
    }
}
