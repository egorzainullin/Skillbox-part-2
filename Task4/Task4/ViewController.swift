//
//  ViewController.swift
//  Task4
//
//  Created by Егор Зайнуллин on 02.02.2022.
//

import UIKit

class ViewController: UIViewController {
    
    var model: ToDoModel!
    
    var currentTasks: [ToDoElement] = []
    
    @IBOutlet weak var tableView: UITableView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        model = ToDoModel.createToDoModel(delegate: self)
        currentTasks = model.getCurrentTasks()
        debugPrint(currentTasks)
        tableView.reloadData()
    }
}


extension ViewController: UITableViewDataSource, UITableViewDelegate {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return currentTasks.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "MainTableViewCell") as! MainTableViewCell
        let element = currentTasks[indexPath.row]
        cell.element = element
        cell.desriptionLabel.text = element.text
        cell.dateOfCreationLabel.text = element.dateOfCreation.description(with: Locale.current)
        cell.dateToDoLabel.text = element.dateToDo.description(with: Locale.current)
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
    }
}

extension ViewController: ElementUpdatedDelegate {
    func elementUpdated(sender: ToDoElement) {
        currentTasks = model.getCurrentTasks()
        tableView.reloadData()
    }
    
    
}

