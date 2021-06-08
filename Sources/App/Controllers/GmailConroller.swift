//
//  GmailConroller.swift
//  
//
//  Created by Red Beard on 08.06.2021.
//

import Vapor

class GmailController {
    func handleWebHook(req: Request) throws -> HTTPResponseStatus {
        print(req.description)
        print(req.body.string ?? "Ничего")
        return HTTPStatus.ok
    }
}
