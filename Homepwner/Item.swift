//
//  Item.swift
//  Homepwner
//
//  Created by Vlad Akhpanov on 19.06.2023.
//

import UIKit

class Item: NSObject, NSCoding, NSSecureCoding {
    var name: String
    var valueInDollars: Int
    var serialNumber: String?
    let dateCreated: Date
    let itemKey: String
    
    let dateFormatter: DateFormatter = {
        let formatter = DateFormatter()
        formatter.dateStyle = .full
        formatter.timeStyle = .full
        return formatter
    }()
    
    static var supportsSecureCoding: Bool = {
        return true
    }()
    
    init(name: String, serialNumber: String?, valueInDollars: Int) {
        self.name = name
        self.serialNumber = serialNumber
        self.valueInDollars = valueInDollars
        self.dateCreated = Date()
        self.itemKey = UUID().uuidString
        
        super.init()
    }
    
    // MARK: - NSCoding
    required init(coder: NSCoder) {
        name = coder.decodeObject(forKey: "name") as! String
        valueInDollars = coder.decodeInteger(forKey: "valueInDollars")
        serialNumber = coder.decodeObject(forKey: "serialNumber") as! String?
        dateCreated = dateFormatter.date(from: coder.decodeObject(forKey: "dateCreated") as! String)!
        itemKey = coder.decodeObject(forKey: "itemKey") as! String
    }
    
    func encode(with coder: NSCoder) {
        coder.encode(name, forKey: "name")
        coder.encode(dateFormatter.string(from: dateCreated), forKey: "dateCreated")
        coder.encode(itemKey, forKey: "itemKey")
        coder.encode(serialNumber, forKey: "serialNumber")
        coder.encode(valueInDollars, forKey: "valueInDollars")
    }
    
    // MARK: -
    convenience init(random: Bool = false) {
        if random {
            let adjectives = ["Fluffy", "Rusty", "Shiny"]
            let nouns = ["Bear", "Spork", "Mac"]
            
            var idx = arc4random_uniform(UInt32(adjectives.count))
            let randomAdjective = adjectives[Int(idx)]
            
            idx = arc4random_uniform(UInt32(nouns.count))
            let randomNoun = nouns[Int(idx)]
            
            let randomName = "\(randomAdjective) \(randomNoun)"
            let randomValue = Int(arc4random_uniform(100))
            let randomSerialNumber = UUID().uuidString.components(separatedBy: ".").first!
            
            self.init(name: randomName, serialNumber: randomSerialNumber, valueInDollars: randomValue)
        } else {
            self.init(name: "", serialNumber: nil, valueInDollars: 0)
        }
    }
}
