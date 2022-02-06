//
//  TasksViewController.swift
//  Task4
//
//  Created by Егор Зайнуллин on 04.02.2022.
//

import UIKit
import Bond
import ReactiveKit

class TasksViewController: UIViewController {

    @IBOutlet weak var deleteButton: UIButton!
    
    @IBOutlet weak var tableView: UITableView!
    
    @IBOutlet weak var makeDoneButton: UIButton!
    
    var viewModel = TasksViewModel()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        bind()
    }
    
    override func viewDidDisappear(_ animated: Bool) {
        super.viewDidDisappear(animated)
        reactive.bag.dispose()
    }
    
    private func bind() {
        viewModel.tasks.bind(to: tableView) {
            dataSource, indexPath, tableView in
            let cell = tableView.dequeueReusableCell(withIdentifier: "MainTableViewCell") as! MainTableViewCell
            let element = dataSource[indexPath.row]
            cell.element = element
            cell.dateOfCreationLabel.text = element.dateOfCreation.description(with: Locale.current)
            cell.dateToDoLabel.text = element.dateToDo.description(with: Locale.current)
            cell.desriptionLabel.text = element.text
            return cell
        }
    }
}
