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
    private let redirectUri = "https://ttmailbot.site/google.oauth2"
    
    func handleAuth(req: Request) throws -> HTTPResponseStatus {
        print(req.url.string)
        print("")
        guard let authCode: String = req.query["code"] else {
            print("auth_code не пришёл")
            return HTTPStatus.ok
        }
        print(authCode)
        print("")
        
        print(getAccessToken(authCode: authCode))
        
        return HTTPStatus.ok
    }
    
    func getAccessToken(authCode: String) -> String {
        print(authCode)
        guard let url = URL(string: tokenUri) else { return "" }
        
        let parameters = [
            "client_id": Environment.googleClientId,
            "client_secret": Environment.googleClientSecret,
            "grant_type": "authorization_code",
            "redirect_uri": redirectUri,
            "code": authCode,
            "access_type": "offline",
            "prompt": "consent"
        ]
        
        let encoder = JSONEncoder()
        encoder.outputFormatting = .withoutEscapingSlashes
        let json = try? encoder.encode(parameters)
        
        var request = URLRequest(url: url)
        request.httpMethod = "POST"
        request.httpBody = json
        
        if let json = try? JSONSerialization.jsonObject(with: json!, options: .mutableContainers),
           let jsonData = try? JSONSerialization.data(withJSONObject: json, options: .prettyPrinted) {
            print(String(decoding: jsonData, as: UTF8.self))
        }
        
        
        let session = URLSession(configuration: .ephemeral)
        session.dataTask(with: request) { (data, response, error) in
            guard let data = data else { return }
            if let json = try? JSONSerialization.jsonObject(with: data, options: .mutableContainers),
               let jsonData = try? JSONSerialization.data(withJSONObject: json, options: .prettyPrinted) {
                print(String(decoding: jsonData, as: UTF8.self))
            } else {
                print("json отсутствует")
            }
        }.resume()
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
