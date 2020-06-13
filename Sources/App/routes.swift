import Fluent
import Vapor

func routes(_ app: Application) throws {
   

    let todoController = TodoController()
    app.get("dialogues", use: todoController.index)
    app.post("dialogues", use: todoController.create)
    app.on(.DELETE, "dialogues", ":todoID", use: todoController.delete)
}
