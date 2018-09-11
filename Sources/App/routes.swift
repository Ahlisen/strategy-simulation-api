import Vapor

/// Register your application's routes here.
public func routes(_ router: Router) throws {
    // Basic "Hello, world!" example
    router.get("hello") { req in
        return "Hello, world!"
    }

    // Example of configuring a controller
    let todoController = TodoController()
    router.get("todos", use: todoController.index)
    router.post("todos", use: todoController.create)
    router.delete("todos", Todo.parameter, use: todoController.delete)

    let simulation = SimulationController()
    router.get("simulation", use: simulation.index)
//    router.post("simulation", use: simulation.addFaction)
}

func load(countriesPath: String) {
//    let path = Bundle.main.path(forResource: countriesPath, ofType: "json")
}

func generateWorld() -> World? {
    return nil
}
