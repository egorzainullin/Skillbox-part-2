//
//  DoneViewController.swift
//  Task4
//
//  Created by Егор Зайнуллин on 04.02.2022.
//

import UIKit

class DoneViewController: UIViewController {
    
    var model: ToDoModel!
    
    var doneOrDeletedTasks: [ToDoElement] = []

    @IBOutlet weak var tableView: UITableView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        model = ToDoModel.createToDoModel(delegate: self)
        doneOrDeletedTasks = model.getDoneAndDeletedTasks()
        tableView.reloadData()
    }
}

extension DoneViewController: UITableViewDataSource, UITableViewDelegate {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        doneOrDeletedTasks.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "DoneTableViewCell") as! DoneTableViewCell
        let element = doneOrDeletedTasks[indexPath.row]
        cell.element = element
        cell.descriptionLabel.text = element.text
        cell.dateToDoLabel.text = element.dateToDo.description(with: Locale.current)
        cell.dateOfCreationLabel.text = element.dateOfCreation.description(with: Locale.current)
        return cell
    }
}

extension DoneViewController: ElementUpdatedDelegate {
    func elementUpdated(sender: ToDoElement) {
        doneOrDeletedTasks = model.getDoneAndDeletedTasks()
        tableView.reloadData()
    }
}
