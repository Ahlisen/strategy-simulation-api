//
//  Country.swift
//  App
//
//  Created by Marcus Ahlström on 2018-09-11.
//

import FluentSQLite
import Vapor

struct Country: SQLiteModel, Content {
    var id: Int?

    let common: String
    let official: String
    let cca3: String

    let capital: String
    let region: String
    let subregion: String

    let latlng: [Double]
    let borders: [String]

    let area: Int
    let flag: String

}
