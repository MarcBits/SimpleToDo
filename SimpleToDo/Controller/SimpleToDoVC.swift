//
//  SimpleToDoVC.swift
//  SimpleToDo
//
//  Created by Marc Cruz on 1/11/18.
//  Copyright © 2018 MarcBits. All rights reserved.
//

import UIKit

class SimpleToDoVC: UITableViewController {
    
    var itemArray = [Item]()
    
    let dataFilePath = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask).first?.appendingPathComponent("Items.plist")

    override func viewDidLoad() {
        super.viewDidLoad()
        
        print(dataFilePath ?? "No dataFilePath set.")
        
        let newItem = Item(itemTitle: "Buy Groceries", itemCompleted: false)
        itemArray.append(newItem)
        
        loadItems()
    }
    
    //MARK: - Tableview Datasource Methods
    
    override func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return itemArray.count
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell = tableView.dequeueReusableCell(withIdentifier: "SimpleToDoItemCell", for: indexPath)
        
        let item = itemArray[indexPath.row]
        
        cell.textLabel?.text = item.title
        
        cell.accessoryType = item.done ? .checkmark : .none

        return cell
    }
    
    //MARK: - Tableview Delegate Methods
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {

        itemArray[indexPath.row].done = !itemArray[indexPath.row].done
        
        saveItems()
        
        tableView.deselectRow(at: indexPath, animated: true)
    }
    
    //MARK: Add New Items
    
    @IBAction func addButtonPressed(_ sender: UIBarButtonItem) {
        
        var textField = UITextField()
        
        let alert = UIAlertController(title: "Add New Item", message: "", preferredStyle: .alert)
        
        let action = UIAlertAction(title: "Add Item", style: .default) { (action) in
            
            let newItem = Item(itemTitle: textField.text!, itemCompleted: false)
            self.itemArray.append(newItem)
            
            self.saveItems()
        }
        
        alert.addTextField { (alertTextField) in
            
            alertTextField.placeholder = "Create new item"
            textField = alertTextField
        }
        
        alert.addAction(action)
        
        present(alert, animated: true, completion: nil)
    }
    
    //MARK: Model Manipulation Methods
    
    func saveItems() {
        let encoder = PropertyListEncoder()
        
        do {
            let data = try encoder.encode(itemArray)
            try data.write(to: dataFilePath!)
        } catch {
            print("Eror encoding item array, \(error)")
        }
        
        self.tableView.reloadData()
    }
    
    func loadItems() {
        let decoder = PropertyListDecoder()
        
        do {
            let data = try Data(contentsOf: dataFilePath!)
            itemArray = try decoder.decode([Item].self, from: data)
        } catch {
            print("Error decoding item array, \(error)")
        }
    }

}

