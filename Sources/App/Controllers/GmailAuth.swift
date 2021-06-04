//
//  GmailAuth.swift
//  
//
//  Created by Red Beard on 02.06.2021.
//

import Vapor

class GmailAuth {
    private let urlAuth = "https://accounts.google.com/o/oauth2/v2/auth"
    private let clientId = "client_id=60847688284-ikl643eo80qo296kk51f61mcrfh6232c.apps.googleusercontent.com"
    
    func handleAuth(req: Request) throws -> HTTPResponseStatus {
        print(req.url.string)
        return HTTPStatus.ok
    }
    
    func getUrlForAuth(for userId: Int64) -> String {
        guard var url = URLComponents(string: urlAuth) else { return "" }
        var items: [URLQueryItem] = []
        let parameters = [
            "response_type" : "code",
            "scope": "email https://www.googleapis.com/auth/userinfo.email openid https://mail.google.com/",
            "access_type": "offline",
            "client_id": "60847688284-ikl643eo80qo296kk51f61mcrfh6232c.apps.googleusercontent.com",
            "redirect_uri": "https://ttmailbot.site/google.oauth2",
            "state": String(userId)
        ]
        for (key, value) in parameters {
            items.append(URLQueryItem(name: key, value: value))
        }
        url.queryItems = items
        
        print(url.query!)
        return url.query! // Явное извлечение опционалов плохая практика
    }
}
