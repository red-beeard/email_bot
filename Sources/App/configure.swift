import Vapor
import Fluent
import FluentPostgresDriver

// configures your application
public func configure(_ app: Application) throws {
    // uncomment to serve files from /Public folder
    // app.middleware.use(FileMiddleware(publicDirectory: app.directory.publicDirectory))
    app.databases.use(.postgres(
                        hostname: "localhost",
                        username: Environment.usernameDatabase,
                        password: Environment.passwordDatabase,
                        database: Environment.database
    ), as: .psql)
//    try app.databases.use(.postgres(url: "Connection to database"), as: .psql)


    // register routes
    
    try routes(app)
}
