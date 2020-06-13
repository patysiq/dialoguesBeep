import Fluent
import Vapor

final class BeepApiModel: Model, Content {
    static let schema = "dialogues"
    
    @ID(key: .id)
    var id: UUID?

    @Field(key: "name")
    var name: String
    
    @Field(key: "text")
    var text: [String]

    init() { }

    init(id: UUID? = nil, name: String, text: [String] ) {
        self.id = id
        self.name = name
        self.text = text
    }
}
