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

// The technical term for this distinction is “value types vs reference types.” Structs are value types, which means they hold simple values such as the number 5 or the string “hello”. It doesn’t matter how many properties or methods your struct has, it’s still considered one simple value like a number. On the other hand, classes are reference types, which means they refer to a value somewhere else.

// using a class rather than a struct sends a strong message that you want the data to be shared somehow, rather than having lots of distinct copies

class Calculator {
    var currentTotal = 0
}
var baseModel = Calculator()
var casio = baseModel
var texas = baseModel
casio.currentTotal = 556
texas.currentTotal = 384
print(casio.currentTotal)
print(texas.currentTotal)

// Class Deinialiser
// Your deinitializer will automatically be called when the final copy of a class instance is destroyed. That might mean it was created inside a function that is now finishing, for example.

// Structs don’t have deinitializers, because you can’t copy them.

class NUser {
    let id: Int
    
    init(id: Int) {
        self.id = id
        print("User \(id): I'm alive!")
    }
    
    deinit {
        print("User \(id): I'm dead!")
    }
}

for i in 1...3 {
    let user = NUser(id: i)
    print("User \(user.id): I'm in control")
}

var users = [NUser]()

for i in 1...3 {
    let user = NUser(id: i)
    print("User \(user.id): I'm in control!")
    users.append(user)
}

print("Loop is finished!")
users.removeAll()
print("Array is clear!")

// Behind the scenes Swift performs something called automatic reference counting, or ARC. ARC tracks how many copies of each class instance exists: every time you take a copy of a class instance Swift adds 1 to its reference count, and every time a copy is destroyed Swift subtracts 1 from its reference count. When the count reaches 0 it means no one refers to the class any more, and Swift will call its deinitializer and destroy the object.

//struct Animals: ~ Copyable {
//    var numberOfLegs: Int
//    
//    init(numberOfLegs: Int) {
//        self.numberOfLegs = numberOfLegs
//    }
//    
//    deinit {
//        print("I'm dead")
//    }
//}

class OUser {
    var name = "Paul"
}

let user = OUser()
user.name = "Taylor" // Putting new name to old user with same posting
print(user.name)

//user = OUser() // No possible because we pointing to a new user by reference
//print(user.name)

// How Reference Works !!
// Constant instance, constant property – a signpost that always points to the same user, who always has the same name.
// Constant instance, variable property – a signpost that always points to the same user, but their name can change.
// Variable instance, constant property – a signpost that can point to different users, but their names never change.
// Variable instance, variable property – a signpost that can point to different users, and those users can also change their names.


var number = 5 // Everytime values changes in a struct. Whole struct is created
number = 6 // That SwiftUI works with struct for UI and classes for data

//class School {
//    let students = 200
//    func expel(student: String, for reason: String) {
//        print("\(student) has been expelled for \(reason).")
//        students -= 1 // You changing count of student
//    }
//}

struct Kindergarten {
    var numberOfScreamingKids = 30
    mutating func handOutIceCream() {
        numberOfScreamingKids = 0
    }
}
let kindergarten = Kindergarten()
//kindergarten.handOutIceCream()

// Checkpoint 7
class Animal {
    var numberOfLegs: Int
    
    init(numberOfLegs: Int) {
        self.numberOfLegs = numberOfLegs
    }
}

class Dog: Animal {
    init() {
        super.init(numberOfLegs: 4)
    }
    
    func speak() {
        print("Generic Dog Voice - Bow, Bow, Bow")
    }
}

class Persian: Dog {
    override func speak() {
        print("Persian Voice - Ba, Ba, Ba")
    }
}

class Lion: Dog {
    override func speak() {
        print("Lion Voice - Raw, Raw, Raw")
    }
}

class Cat: Animal {
    var isTame: Bool
    
    init(isTame: Bool) {
        self.isTame = isTame
        super.init(numberOfLegs: 4)
    }
    
    func speak() {
        print("Generic Cat Voice - Meow, Meow, Meow")
    }
}

class Corgi: Cat {
    
    override func speak() {
        print("Corgi Voice - Mi, Mi, Mi")
    }
}

class Poodle: Cat {
    override func speak() {
        print("Poodle Voice - Mow, Mow, Mow")
    }
}

let animal = Animal(numberOfLegs: 4)
let corgiCat = Corgi(isTame: true)
corgiCat.speak()
