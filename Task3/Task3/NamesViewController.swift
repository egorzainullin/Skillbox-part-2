//
//  NamesViewController.swift
//  Task3
//
//  Created by Егор Зайнуллин on 29.01.2022.
//

import UIKit
import Bond
import ReactiveKit

class NamesViewController: UIViewController {
    
    @IBOutlet weak var tableView: UITableView!
    
    @IBOutlet weak var searchTextField: UITextField!
    
    var names = MutableObservableArray<String>()
    
    var allNames = ["Anton", "Nikita", "Alex", "Misha",
                    "Tanya", "Yulya", "Pasha", "Sasha",
                    "Dasha", "Vanya", "Vanya2", "Tony",
                    "Peter", "Norman", "Kurt", "Richard",
                    "Danya", "Sonya", "Ruslan", "Ruslan2"]
    
    var newNames = [String]()
    
    var textToSearch = Property("")
    
    @IBAction func addName(_ sender: Any) {
        names.insert("Random Name", at: 0)
    }
    
    @IBAction func deleteName(_ sender: Any) {
        names.remove(at: names.count - 1)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        names.insert(contentsOf: allNames, at: 0)
        searchTextField.reactive.text
            .throttle(for: 2)
                    .observeNext {value in
                        if let value = value,
                           !value.isEmpty {
                            self.newNames = self.allNames.filter { (name: String) -> Bool in
                                return name.lowercased().contains(value.lowercased())
                            }
                            self.names.removeAll()
                            self.names.insert(contentsOf: self.newNames, at: 0)
                        }
                        else {
                            self.names.insert(contentsOf: self.allNames, at: 0)
                        }
                    }
                    .dispose(in: reactive.bag)
        names
            .bind(to: tableView) {(dataSource, indexPath, tableView) -> UITableViewCell in
            let cell = tableView.dequeueReusableCell(withIdentifier: "NameTableViewCell") as! NameTableViewCell
            cell.nameLabel.text = dataSource[indexPath.row]
            return cell
        }
        // Do any additional setup after loading the view.
    }
    
    override func viewDidDisappear(_ animated: Bool) {
        super.viewDidDisappear(animated)
        reactive.bag.dispose()
    }
}
