//
//  Faction.swift
//  App
//
//  Created by Marcus Ahlström on 2018-09-11.
//

import FluentSQLite
import Vapor

struct Faction: SQLiteModel, Content {
    var id: Int?

    let name: String
    let members: [Member]
    let countries: [Country.ID]
}

struct Member: SQLiteModel, Content {
    var id: Int?

    let name: String
    let email: String

    let army: Int
}

struct World: SQLiteModel, Content {
    var id: Int?

    let countries: [Country]
    let factions: [Faction]
}
