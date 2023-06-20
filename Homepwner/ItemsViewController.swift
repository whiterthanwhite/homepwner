//
//  ItemsViewController.swift
//  Homepwner
//
//  Created by Vlad Akhpanov on 19.06.2023.
//

import UIKit

class ItemsViewController: UITableViewController {
    var itemStore: ItemStore!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        let window = self.refreshControl?.window
        let statusBarMgr = window?.windowScene?.statusBarManager
        
        let statusBarHeight = statusBarMgr?.statusBarFrame.height ?? 0.0
        let insets = UIEdgeInsets(top: statusBarHeight, left: 0, bottom: 0, right: 0)
        tableView.contentInset = insets
        tableView.scrollIndicatorInsets = insets
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return itemStore.allItems.count
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "UITableViewCell", for: indexPath)
        let item = itemStore.allItems[indexPath.row]
        
        var c = UIListContentConfiguration.cell()
        c.text = item.name
        c.secondaryText = "$\(item.valueInDollars)"
        cell.contentConfiguration = c
        
        return cell
    }
}
