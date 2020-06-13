import Fluent
import Vapor

func routes(_ app: Application) throws {
   

    let beepController = BeepController()
    app.get("dialogues", use: beepController.index)
    app.post("tdialogues", use: beepController.create)
    app.on(.DELETE, "dialogues", ":todoID", use: beepController.delete)
}
