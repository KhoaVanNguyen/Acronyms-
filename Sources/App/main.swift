import Vapor
import VaporPostgreSQL
let drop = Droplet(
    preparations: [Acronym.self],
    providers: [VaporPostgreSQL.Provider.self]
)

drop.get("version") { request in
    if let db = drop.database?.driver as? PostgreSQLDriver{
        let version = try db.raw("SELECT  version() ")
        return try JSON(node: version)
    }else {
        return "No database connection"
    }
}

drop.get("/"){ request in
    let acronym1 = Acronym(short: "YOLO", long: "you only live one life")
    
//    let node = try acronym1.makeNode()
    return try acronym1.makeJSON()
    
    
}

drop.get("test"){ request in
    var acronym1 = Acronym(short: "YOLO", long: "you only live one life")
    try acronym1.save()
    return try JSON(node: Acronym.all().makeNode())
    
}



drop.run()
