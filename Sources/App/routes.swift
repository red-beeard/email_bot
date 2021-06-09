import Vapor

func routes(_ app: Application) throws {
    app.post("WebHook", use: BotController().handleWebHook)
    app.get("google.oauth2", use: GoogleAuthController().handleAuth)
    app.post("WebHookGmail", use: GmailController().handleWebHook)
    
    app.get() { req -> HTTPResponseStatus in
        print("Полученный запрос:")
        print(req.description)
        return HTTPStatus.ok
    }
}
