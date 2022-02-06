//
//  AddTaskViewController.swift
//  Task4
//
//  Created by Егор Зайнуллин on 04.02.2022.
//

import UIKit

class AddTaskViewController: UIViewController {

    @IBOutlet weak var datePicker: UIDatePicker!
    
    @IBOutlet weak var textOfTaskTextField: UITextField!
    
    @IBOutlet weak var addTaskButton: UIButton!
    
    let viewModel = AddViewModel()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        bind()
    }
    
    override func viewDidDisappear(_ animated: Bool) {
        super.viewDidDisappear(animated)
        reactive.bag.dispose()
    }
    
    func bind() {
        datePicker.reactive.date.bind(to: viewModel.dateToDo)
        textOfTaskTextField.reactive.text
            .ignoreNils()
            .bind(to: viewModel.text)
        addTaskButton.reactive.tap.observeNext {
            self.viewModel.addTask()
        }
        .dispose(in: reactive.bag)
    }
}
