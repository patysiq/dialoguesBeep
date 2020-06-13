@testable import App
import Fluent
import XCTVapor

final class AppTests: XCTestCase {
    func testCreateTodo() throws {
        let app = Application(.testing)
        defer { app.shutdown() }
        try configure(app)

        // replace default database with in-memory db for testing
        app.databases.use(.sqlite(.memory), as: .test, isDefault: true)
        // run migrations automatically
        try app.autoMigrate().wait()

        try app.test(.GET, "todos") { res in
            XCTAssertContent([Todo].self, res) {
                XCTAssertEqual($0.count, 0)
            }
        }.test(.POST, "todos", beforeRequest: { req in
            try req.content.encode(Todo())
        }, afterResponse:  { res in
            XCTAssertContent(Todo.self, res) {
                XCTAssertNotNil($0.id)
                XCTAssertEqual($0.name, "Test My App")
                XCTAssertEqual($0.text, ["Test My App"])
            }
        }).test(.GET, "todos") { res in
            XCTAssertContent([Todo].self, res) {
                XCTAssertEqual($0.count, 1)
            }
        }
    }
}

extension DatabaseID {
    static var test: Self {
        .init(string: "test")
    }
}
