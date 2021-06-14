//
// Created by konstantin on 14.06.2021.
//

import PostgresNIO
import Foundation
import Vapor
#if canImport(FoundationNetworking)
import FoundationNetworking
#endif

class DBHelpers {
    static var db: PostgresDatabase? = nil

    static func initDB() throws {
        let eventLoop = MultiThreadedEventLoopGroup(numberOfThreads: 1)
        let conn = try PostgresConnection.connect(
                to: .makeAddressResolvingHost("localhost", port: 5432),
                on: eventLoop.next()
        ).wait()
        try conn.authenticate(
                username: Environment.usernameDatabase,
                database: Environment.database,
                password: Environment.passwordDatabase
        ).wait()
        db = conn
        try createDB()
        try versionDump()
    }

    static func createDB() throws {
        let drop = try db?.simpleQuery("DROP TABLE IF EXISTS google_email;").wait()
        let path = URL(fileURLWithPath: "/home/ubuntu/vapor_bot/Resources/SQL/create.sql")
        let data = try Data(contentsOf: path)
        let sql_create = String(decoding: data, as: UTF8.self)
        try db?.simpleQuery(sql_create).wait()
    }

    static func versionDump() throws {
        let version = try db?.simpleQuery("SELECT version()").wait()
        print("LOG version:", version)
    }


    static func addUserIfNeed(newUser user: ProfileResponse, newToken token: AuthResponse) throws {
        let binds: [PostgresData] = [
            PostgresData(string: user.historyId),
            PostgresData(string: token.accessToken),
            PostgresData(string: token.refreshToken ?? ""),
            PostgresData(string: user.emailAddress)
        ]
        let result = try db?.query("""
                                   INSERT INTO google_email
                                   (user_id, access_token, refresh_token, email_address, chat_id)
                                   VALUES 
                                   ($1,      $2,           $3,            $4,            $5)
                                   ON CONFLICT DO NOTHING;
                                   """, binds
        ).wait()

        print("QUERY result:", result)
    }

    static func getUserDataByEmail(email: String) throws -> [UserDB]? {

        let binds: [PostgresData] = [PostgresData(string: email)]
        let result = try db?.query("""
                                   SELECT to_jsonb(array_agg(google_email)) FROM google_email WHERE email_address = $1;
                                   """, binds
        ).wait()
        return try toArray(input: result, as: [UserDB].self)
    }

    static func getUserDataById(id: Int) throws -> [UserDB]? {

        let binds: [PostgresData] = [PostgresData(int: id)]
        let result = try db?.query("""
                                   SELECT to_jsonb(array_agg(google_email)) FROM google_email WHERE user_id = $1;
                                   """, binds
        ).wait()
        return try toArray(input: result, as: [UserDB].self)
    }


    static func toArray<T>(input: PostgresQueryResult?, as type: T.Type) throws -> T? where T: Decodable {
        var res = try input!.rows[0].dataRow.columns[0].value
        if (res == nil) {
            return nil
        }

        let data = try res?.getData(at: 1, length: res!.capacity - 1)
        let users = try JSONDecoder().decode(type, from: data!)
        print("LOG", users)
        return users
    }

}
