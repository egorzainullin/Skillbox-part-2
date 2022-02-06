//
//  AddViewModel.swift
//  Task4
//
//  Created by Егор Зайнуллин on 05.02.2022.
//

import Foundation
import ReactiveKit
import Bond

class AddViewModel {
    var text = Property("")
    
    var dateToDo = Property(Date())
    
    private var model: ToDoModel!
    
    init() {
        model = ToDoModel.createToDoModel(delegate: nil)
    }
    
    func addTask() {
        let element = ToDoElement()
        element.update(isDone: false, isDeleted: false, dateToDo: dateToDo.value, text: text.value)
        model.addTask(element: element)
    }
}
