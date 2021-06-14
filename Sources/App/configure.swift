import Vapor

// configures your application
public func configure(_ app: Application) throws {
    try DBHelpers.initDB()

    // register routes
    
    try routes(app)
}
