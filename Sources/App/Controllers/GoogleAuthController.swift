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

//struct AuthClient: Content {
//    let id_token: String
//    let access_token: String
//    let token_type: String
//    let expires_in: Int
//    let scope: String
//    let refresh_token: String?
//}

class GoogleAuthController {
    private let authUri = "https://accounts.google.com/o/oauth2/v2/auth"
    private let tokenUri = "https://oauth2.googleapis.com/token"
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
        
        DispatchQueue.main.async {
            let futureAuthClient = self.getAuthClient(for: req, and: authCode)
            futureAuthClient.whenSuccess { client in
                print(client?.accessToken ?? "Нет access token")
                if client?.refreshToken == nil {
                    try? BotController().sendMessage(with: self.alreadyLoggedMessage, to: userId)
                }
            }
//
//            guard let authClient = self.getAuthClient(for: req, and: authCode) else {
//                return HTTPStatus.ok
//            }

//            if authClient.refreshToken == nil {
//                try? BotController().sendMessage(with: alreadyLoggedMessage, to: userId)
//            }
        }
        return HTTPStatus.ok
    }
    
    func getAuthClient(for req: Request, and authCode: String) -> EventLoopFuture<AuthClient?> {
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
        }.map { res in
            return try? res.content.decode(AuthClient.self)
        }
        
        // Получить AuthClient
        print(response)

        
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
