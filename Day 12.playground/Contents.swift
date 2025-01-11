import Cocoa

var greeting = "Hello, playground"


// Classes
// Similarties between Structures and Classes

// You get to create and name them.
// You can add properties and methods, including property observers and access control.
// You can create custom initializers to configure new instances however you want.

// Differences between Structures and Classes
// You can make one class build upon functionality in another class, gaining all its properties and methods as a starting point. If you want to selectively override some methods, you can do that too.
// Because of that first point, Swift won’t automatically generate a memberwise initializer for classes. This means you either need to write your own initializer, or assign default values to all your properties.
// When you copy an instance of a class, both copies share the same data – if you change one copy, the other one also changes.
// When the final copy of a class instance is destroyed, Swift can optionally run a special function called a deinitializer.
// Even if you make a class constant, you can still change its properties as long as they are variables.
// Because one instance of a class can be referenced in several places, it becomes important to know when the final copy has been destroyed. That’s where the deinitializer comes in: it allows us to clean up any special resources we allocated when that last copy goes away

class Game {
    var score: Int = 0 {
        didSet {
            print("Score is now \(score)")
        }
    }
}

var newGame = Game()
newGame.score += 10

class ThemePark {
    var entryPrice: Int
    var rides: [String]
    init(rides: [String]) {
        self.rides = rides
        self.entryPrice = rides.count * 2
    }
}

class Empty  {}
let emptyObject = Empty()

class Attendee {
    var badgeNumber = 0
    var name = "Anonymous"
    var company = "Unknown"
    init(badge: Int) {
        self.badgeNumber = badge
    }
}

class Employee {
    let hours: Int
    init(hours: Int) {
        self.hours = hours
    }
    
    func printSummary() {
        print("I work \(hours) hours a day.")
    }
    
    private func printEmployeeSecretDetails() { // final stop this function to be inherited further
        print("YOUR SECRET DETAILS")
    }

}

class Developer: Employee {
    func work() {
        print("I'm writing code for \(hours) hours.")
    }
    
    override func printSummary() {
        print("I'm a developer who work extra so my hours are \(hours + 2)")
    }
}

final class Manager: Employee { // final stop this anyone to inherite from this class
    func work() {
        print("I'm going to meetings for \(hours) hours.")
    }
}

class JuniorManager: Employee { }

let robert = Developer(hours: 16)
let joseph = Manager(hours: 10)
robert.work()
joseph.work()

robert.printSummary()
joseph.printSummary()

// Class Initialisers
class Vehicle {
    let isElectric: Bool

    init(isElectric: Bool) {
        self.isElectric = isElectric
    }
}

class Car: Vehicle {
    let isConvertible: Bool
    
    init(isConvertible: Bool, isElectric: Bool) {
        self.isConvertible = isConvertible
//        ...
//        ...
//        ...
        // At the end
        super.init(isElectric: isElectric)
    }
}

let teslaX = Car(isConvertible: true, isElectric: false)

// Copies of class
class User {
    var username = "Anonymous"
    
    func copy() -> User { // Deep Copy
        let user = User()
        user.username = username
        return user
    }
}

var user1 = User()
user1.username

var user2 = user1.copy()
user2.username

user2.username = "Walter White"

user2.username
user1.username

// If you want to create a unique copy of a class instance – sometimes called a deep copy – you need to handle creating a new instance and copy across all your data safely
