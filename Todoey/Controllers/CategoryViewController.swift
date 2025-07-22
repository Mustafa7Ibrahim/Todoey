//
//  CategoryViewController.swift
//  Todoey
//
//  Created by Mustafa on 22/07/2025.
//  Copyright © 2025 App Brewery. All rights reserved.
//

import UIKit
import CoreData

class CategoryViewController: UITableViewController {
    
    var categories = [CategoryTable]()
    let context = (UIApplication.shared.delegate as! AppDelegate).persistentContainer.viewContext

    override func viewDidLoad() {
        super.viewDidLoad()
        loadData()
    }

    // MARK: - Table view data source

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return categories.count
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "CategoryCell", for: indexPath)
        let item = categories[indexPath.row]
        
        var content = cell.defaultContentConfiguration()
        content.text = item.name
        cell.contentConfiguration = content
        return cell
    }
    
    // MARK: - TableView Delegate Methods
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        // here will be the push of the screen to todoListController
    }
    
    // MARK: - Data Manipulation Methods

    @IBAction func AddButtonPressed(_ sender: UIBarButtonItem) {
        var textFeild = UITextField()
        let alert = UIAlertController(title: "Add New Category", message: "", preferredStyle: .alert)
        alert.addTextField { (field) in
            textFeild.placeholder = "Add a new category"
            textFeild = field
        }
        alert.addAction(UIAlertAction(title: "Add", style: .default) { [self] action in
            if let textFeild = textFeild.text {
                let newCategory = CategoryTable(context: self.context)
                newCategory.name = textFeild
                categories.append(newCategory)
                self.saveDate()
            }
        })
        present(alert, animated: true)
    }
    
    func loadData(with request: NSFetchRequest<CategoryTable> = CategoryTable.fetchRequest()) {
        do {
            categories = try context.fetch(request)
        } catch {
            print("Error fetching data from CoreData... \(error)")
        }
        tableView.reloadData()
    }
    
    func saveDate() {
        do {
            try context.save()
        } catch {
            print("Error saving context... \(error)")
        }
        tableView.reloadData()
    }
}
