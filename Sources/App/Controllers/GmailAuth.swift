//
//  GmailAuth.swift
//  
//
//  Created by Red Beard on 02.06.2021.
//

import Vapor

class GmailAuth {
    func handleWebHook(req: Request) throws -> HTTPResponseStatus {
        print(try req.body.string ?? "mlml")
        return HTTPStatus.ok
    }
}
