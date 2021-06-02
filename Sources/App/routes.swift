import Vapor

func routes(_ app: Application) throws {
    app.post("WebHook", use: BotController().handleWebHook)
    app.post("google.oauth2", use: GmailAuth().handleWebHook)
    app.get("google.oauth2", use: GmailAuth().handleWebHook)
}
