import Vapor

func routes(_ app: Application) throws {
    app.post("WebHook", use: BotController().handleWebHook)
}
