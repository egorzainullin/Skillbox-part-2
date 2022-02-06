//
//  DoneRasksViewModel.swift
//  Task4
//
//  Created by Егор Зайнуллин on 05.02.2022.
//

import Foundation
import ReactiveKit
import Bond

class DoneTasksViewModel {
    var tasks =  MutableObservableArray<ToDoElement>()
    var model: ToDoModel!
    
    init() {
        model = ToDoModel.createToDoModel(delegate: self)
        tasks.insert(contentsOf: model.getDoneAndDeletedTasks(), at: 0)
    }
}

extension DoneTasksViewModel: ElementUpdatedDelegate {
    func elementUpdated(sender: ToDoElement) {
        tasks.removeAll()
        tasks.insert(contentsOf: model.getDoneAndDeletedTasks(), at: 0)
    }
}
