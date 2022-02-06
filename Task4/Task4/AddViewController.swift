//
//  AddViewController.swift
//  Task4
//
//  Created by Егор Зайнуллин on 03.02.2022.
//

import UIKit

class AddViewController: UIViewController {

    @IBOutlet weak var datePicker: UIDatePicker!
    
    @IBOutlet weak var taskTextField: UITextField!
    
    let model = ToDoModel.createToDoModel(delegate: nil)
    
    @IBAction func addTask(_ sender: Any) {
        let element = ToDoElement()
        element.update(isDone: false, isDeleted: false, dateToDo: datePicker.date, text: taskTextField.text ?? "")
        model.addTask(element: element)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
    }
}
