//
//  SimulationController.swift
//  App
//
//  Created by Marcus Ahlström on 2018-09-11.
//

import Vapor
import Jobs

final class SimulationController {

    var number: Int = 0
//    let world: World

    init() {
//        self.world = world

        Jobs.add(interval: 3.seconds) {
            self.number += 1
        }
    }

    func simulate() {

    }

    func index(_ req: Request) throws -> Int {
        return self.number
    }

    /// Saves a decoded `Faction` to the database.
    func faction(_ req: Request) throws -> Future<Faction> {
        return try req.content.decode(Faction.self).flatMap { faction in
            print("I WAS DECODED ", faction.name)
            return faction.save(on: req)
        }
    }

}
