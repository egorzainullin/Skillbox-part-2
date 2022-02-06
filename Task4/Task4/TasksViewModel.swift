//
//  TasksViewModel.swift
//  Task4
//
//  Created by Егор Зайнуллин on 04.02.2022.
//

import Foundation
import Bond
import ReactiveKit

class TasksViewModel{
    
    var tasks =  MutableObservableArray<ToDoElement>()
    
    var model: ToDoModel!
    
    init() {
        model = ToDoModel.createToDoModel(delegate: self)
        tasks.insert(contentsOf: model.getCurrentTasks(), at: 0)
    }
}

extension TasksViewModel: ElementUpdatedDelegate {
    func elementUpdated(sender: ToDoElement) {
        tasks.removeAll()
        tasks.insert(contentsOf: model.getCurrentTasks(), at: 0)
    }
}


    
