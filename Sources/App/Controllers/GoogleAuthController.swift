//
//  GoogleAuthController.swift
//  
//
//  Created by Red Beard on 02.06.2021.
//

import Vapor

class GoogleAuthController {
    private let urlAuth = "https://accounts.google.com/o/oauth2/v2/auth"
    private let clientId = "client_id=60847688284-ikl643eo80qo296kk51f61mcrfh6232c.apps.googleusercontent.com"
    
    func handleAuth(req: Request) throws -> HTTPResponseStatus {
        print(req.url.string)
        return HTTPStatus.ok
    }
    
//    private func getShortUrl(for url: String) -> String {
//        guard var url = URLComponents(string: "https://clck.ru/--") else { return }
//        url.queryItems = [URLQueryItem(name: "url", value: url)]
//
//        var request = URLRequest(url: (url.url)!)
//        // Явное извлечения опционала плохая практика
//        request.httpMethod = "POST"
//        request.httpBody = json
//
//        let session = URLSession(configuration: .ephemeral)
//        session.dataTask(with: request) { (data, response, error) in
//            if let data = data {
//                let responseData = try! JSONDecoder().decode(ErrorApiTamtam.self, from: data)
//                print("code: \(responseData.code)")
//                print("message: \(responseData.message)")
//            }
//            if let response = response {
//                let httpResponse = response as! HTTPURLResponse
//                print("response code = \(httpResponse.statusCode)")
//            }
//        }.resume()
//    }
    
    func getUrlForAuth(for userId: Int64) -> String {
        guard var url = URLComponents(string: urlAuth) else { return "" }
        var items: [URLQueryItem] = []
        let parameters = [
            "response_type" : "code",
            "scope": "email https://mail.google.com",
            "access_type": "offline",
            "client_id": "60847688284-ikl643eo80qo296kk51f61mcrfh6232c.apps.googleusercontent.com",
            "redirect_uri": "https://ttmailbot.site/google.oauth2",
            "state": String(userId)
        ]
        for (key, value) in parameters {
            items.append(URLQueryItem(name: key, value: value))
        }
        url.queryItems = items
        
        url.query = url.query?.addingPercentEncoding(withAllowedCharacters: .urlQueryAllowed)

        print(url.string!)
        return url.string! // Явное извлечение опционалов плохая практика
    }
}
