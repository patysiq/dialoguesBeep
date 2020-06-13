import Fluent
import Vapor

struct BeepController {
    func index(req: Request) throws -> EventLoopFuture<[BeepApiModel]> {
        return BeepApiModel.query(on: req.db).all()
    }

    func create(req: Request) throws -> EventLoopFuture<BeepApiModel> {
        let beep = try req.content.decode(BeepApiModel.self)
        return beep.save(on: req.db).map { beep }
    }

    func delete(req: Request) throws -> EventLoopFuture<HTTPStatus> {
        return BeepApiModel.find(req.parameters.get("ID"), on: req.db)
            .unwrap(or: Abort(.notFound))
            .flatMap { $0.delete(on: req.db) }
            .map { .ok }
    }
}
