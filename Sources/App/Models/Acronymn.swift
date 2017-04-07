import Vapor


final class Acronym: Model{
    
    var id: Node?
    var short: String
    var long: String
    
    init(node: Node, in context: Context) throws {
        self.id = try node.extract("id")
        self.short = try node.extract("short")
        self.long = try node.extract("long")
    }
    init(short: String, long: String) {
        self.id = nil
        self.short = short
        self.long = long
    }
   
    func makeNode(context: Context) throws -> Node {
        let node = try ["short": short, "long": long  ].makeNode()
        return node
    }
    
    static func prepare(_ database: Database) throws {
        try database.create("acronyms", closure: { (user) in
            user.id()
            user.string("short")
            user.string("long")
        })
    }
    
    static func revert(_ database: Database) throws {
        try database.delete("acronyms")
    }
    
    
}
