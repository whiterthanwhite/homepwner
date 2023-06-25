//
//  ItemStore.swift
//  Homepwner
//
//  Created by Vlad Akhpanov on 20.06.2023.
//

import UIKit

class ItemStore {
    var allItems = [Item]()
    let itemArchiveURL: URL = {
        let documentsDirectories = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask)
        let documentDirectory = documentsDirectories.first!
        return documentDirectory.appending(path: "items.archive")
    }()
    
    init() {
        if let nsData = NSData(contentsOf: itemArchiveURL) {
            let data = nsData as Data
            do {
                let unarchivedData = try NSKeyedUnarchiver.unarchivedArrayOfObjects(ofClasses: [NSString.self, Item.self], from: data)
                allItems = unarchivedData as! [Item]
            } catch {
                print(error)
            }
        }
    }
    
    @discardableResult func createItem() -> Item {
        let newItem = Item(random: true)
        
        allItems.append(newItem)
        
        return newItem
    }
    
    func removeItem(_ item: Item) {
        if let index = allItems.firstIndex(of: item) {
            allItems.remove(at: index)
        }
    }
    
    func moveItem(from fromIndex: Int, to toIndex: Int) {
        if fromIndex == toIndex {
            return
        }
        
        let movedItem = allItems[fromIndex]
        allItems.remove(at: fromIndex)
        allItems.insert(movedItem, at: toIndex)
    }
    
    func saveChanges() -> Bool {
        print("Saving items to: \(itemArchiveURL.path)")
        do {
            let data = try NSKeyedArchiver.archivedData(withRootObject: allItems, requiringSecureCoding: true)
            try data.write(to: itemArchiveURL)
            return true
        } catch {
            print(error)
            return false
        }
    }
}
