import Fluent

struct CreateBeep: Migration {
    func prepare(on database: Database) -> EventLoopFuture<Void> {
        return database.schema("dialogues")
            .id()
            .field("name", .string, .required)
            .field("text", .string, .required)
            .create()
    }

    func revert(on database: Database) -> EventLoopFuture<Void> {
        return database.schema("dialogues").delete()
    }
}
