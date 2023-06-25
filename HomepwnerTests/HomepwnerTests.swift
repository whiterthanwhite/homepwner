//
//  HomepwnerTests.swift
//  HomepwnerTests
//
//  Created by Vlad Akhpanov on 19.06.2023.
//

import XCTest
@testable import Homepwner

class Person: NSObject, NSCoding, NSSecureCoding {
    let name: String
    let lastName: String
    let age: Int
    let birthday: Date
    let currDate: Date
    let dateFormatter: DateFormatter = {
        let formatter = DateFormatter()
        formatter.dateStyle = .short
        formatter.timeStyle = .short
        return formatter
    }()
    static var supportsSecureCoding: Bool = {
        return true
    }()
    
    required init?(coder: NSCoder) {
        name = coder.decodeObject(forKey: "name") as! String
        lastName = coder.decodeObject(forKey: "lastName") as! String
        age = coder.decodeInteger(forKey: "age")
        
        let birthdayString = coder.decodeObject(forKey: "birthday") as! String
        birthday = dateFormatter.date(from: birthdayString)!
        let currDateString = coder.decodeObject(forKey: "currDate") as! String
        currDate = dateFormatter.date(from: currDateString)!
    }
    
    init(_ name: String, _ lastName: String, _ age: Int) {
        self.name = name
        self.lastName = lastName
        self.age = age
        
        let date = Date()
        let dateComp = DateComponents(year: -age)
        let cal = Calendar.current
        
        self.birthday = cal.date(byAdding: dateComp, to: date)!
        self.currDate = date
    }
    
    func encode(with coder: NSCoder) {
        coder.encode(name, forKey: "name")
        coder.encode(lastName, forKey: "lastName")
        coder.encode(age, forKey: "age")
        print(" >>> \(birthday) >>> \(dateFormatter.string(from: birthday))")
        coder.encode(dateFormatter.string(from: birthday), forKey: "birthday")
        print(" >>> \(currDate) >>> \(dateFormatter.string(from: currDate))")
        coder.encode(dateFormatter.string(from: currDate), forKey: "currDate")
    }
    
    func toString() -> String {
        return """
            Name: \(name)
            Last name: \(lastName)
            Age: \(age)
            Birthday: \(birthday)
            CurrDate: \(currDate)
        """
    }
}

final class HomepwnerTests: XCTestCase {

    override func setUpWithError() throws {
        // Put setup code here. This method is called before the invocation of each test method in the class.
    }

    override func tearDownWithError() throws {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
    }

    func testExample() throws {
        // This is an example of a functional test case.
        // Use XCTAssert and related functions to verify your tests produce the correct results.
        // Any test you write for XCTest can be annotated as throws and async.
        // Mark your test throws to produce an unexpected failure when your test encounters an uncaught error.
        // Mark your test async to allow awaiting for asynchronous code to complete. Check the results with assertions afterwards.
    }
    
    func testPerson() throws {
        let person = Person("Vlad", "Akhpanov", 28)
        let data = try! NSKeyedArchiver.archivedData(withRootObject: person, requiringSecureCoding: true)
        if let newPerson = try! NSKeyedUnarchiver.unarchivedObject(ofClass: Person.self, from: data) {
            print(newPerson.toString())
        }
        
        let persons = [
            Person("Vlad", "Akhpanov", 28),
            Person("Anjelika", "Maslova", 25)
        ]
        let personsData = try! NSKeyedArchiver.archivedData(withRootObject: persons, requiringSecureCoding: true)
        if let newPersons = try! NSKeyedUnarchiver.unarchivedArrayOfObjects(ofClass: Person.self, from: personsData) {
            for p in newPersons {
                print(p.toString())
            }
        }
        
    }
    
    func testPerformanceExample() throws {
        // This is an example of a performance test case.
        self.measure {
            // Put the code you want to measure the time of here.
        }
    }

}
