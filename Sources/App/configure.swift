import FluentSQLite
import Vapor
import Jobs

/// Called before your application initializes.
public func configure(_ config: inout Config, _ env: inout Environment, _ services: inout Services) throws {
    /// Register providers first
    try services.register(FluentSQLiteProvider())

    /// Register routes to the router
    let router = EngineRouter.default()
    try routes(router)
    services.register(router, as: Router.self)

    /// Register middleware
    var middlewares = MiddlewareConfig() // Create _empty_ middleware config
    /// middlewares.use(FileMiddleware.self) // Serves files from `Public/` directory
    middlewares.use(ErrorMiddleware.self) // Catches errors and converts to HTTP response
    services.register(middlewares)

    // Configure a SQLite database
    let sqlite = try SQLiteDatabase(storage: .memory)

    /// Register the configured SQLite database to the database config.
    var databases = DatabasesConfig()
    databases.add(database: sqlite, as: .sqlite)
    services.register(databases)

    /// Configure migrations
    var migrations = MigrationConfig()
    migrations.add(model: Todo.self, database: .sqlite)
    services.register(migrations)

    // Create a new NIO websocket server
    let wss = NIOWebSocketServer.default()

    // Add WebSocket upgrade support to GET /echo
    wss.get("echo") { ws, req in
        // Add a new on text callback

        // Every 5 seconds send json to client

        let encoder = JSONEncoder()

        Jobs.add(interval: 5.seconds) {
            let todo = Todo(title: "Här kommer json")
            let data = try? encoder.encode(todo)
            if let strongData = data {
                ws.send(strongData)
            }
        }

//        ws.onText { ws, text in
//            ws.send(text)
//        }
    }

    // Register our server
    services.register(wss, as: WebSocketServer.self)
}
