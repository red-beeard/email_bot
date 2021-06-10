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

struct AuthClient: Content {
    let id_token: String
    let access_token: String
    let token_type: String
    let expires_in: String
    let scope: String
    let refresh_token: String?
}

class GoogleAuthController {
    private let authUri = "https://accounts.google.com/o/oauth2/v2/auth"
    private let tokenUri = "https://oauth2.googleapis.com/token"
    private let redirectUri = "https://ttmailbot.site/google.oauth2"
    private var someVar = "someVar"
    
    func handleAuth(req: Request) throws -> HTTPResponseStatus {
        print(req.url.string)
        print("")
        guard let authCode: String = req.query["code"] else {
            print("auth_code не пришёл")
            return HTTPStatus.ok
        }
        print(authCode)
        print("")
        
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
            let result = try! res.content.decode(AuthClient.self)
            print(result.access_token)
        }
        
        
//        print(getAccessToken(authCode: authCode))
        print(someVar)
        
        return HTTPStatus.ok
    }
    
    func getAccessToken(authCode: String) -> String {
        guard let url = URL(string: tokenUri) else { return "" }
        print(Unmanaged.passUnretained(self).toOpaque())
        
        let parameters = [
            "client_id": Environment.googleClientId,
            "client_secret": Environment.googleClientSecret,
            "grant_type": "authorization_code",
            "redirect_uri": redirectUri,
            "code": authCode,
            "access_type": "offline",
            "prompt": "consent"
        ]
        
        let json = try? JSONEncoder().encode(parameters)
        
        var request = URLRequest(url: url)
        request.httpMethod = "POST"
        request.httpBody = json
        request.setValue("application/json", forHTTPHeaderField: "Content-Type")
        
        let session = URLSession(configuration: .ephemeral)
        session.dataTask(with: request) { (data, response, error) in
            guard let data = data else { return }
            if let json = try? JSONSerialization.jsonObject(with: data, options: .mutableContainers),
               let jsonData = try? JSONSerialization.data(withJSONObject: json, options: .prettyPrinted) {
                print(String(decoding: jsonData, as: UTF8.self))
            } else {
                print("json отсутствует")
            }
            DispatchQueue.main.sync {
                self.someVar = "response"
            }
            
        }.resume()
        print(someVar)
        return ""
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
