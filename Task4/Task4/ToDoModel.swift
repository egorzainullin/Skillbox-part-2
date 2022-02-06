//
//  ToDoModel.swift
//  Task4
//
//  Created by Егор Зайнуллин on 02.02.2022.
//

import Foundation
import RealmSwift

class ToDoElement: Object {
    @Persisted var isDone: Bool
    { didSet {notify()}}
    
    @Persisted var isDeleted: Bool
    { didSet {notify()}}
    
    @Persisted var dateOfCreation: Date
    { didSet {notify()}}
    
    @Persisted var dateToDo: Date
    { didSet {notify()}}
    
    @Persisted var text: String
    { didSet {notify()}}
    
    var delegates: [ElementUpdatedDelegate] = []
    
    private func notify() {
        for delegate in delegates {
            delegate.elementUpdated(sender: self)
        }
    }
    
    func update(isDone: Bool, isDeleted: Bool, dateToDo: Date, text: String) {
        self.isDone = isDone
        self.isDeleted = isDeleted
        self.dateOfCreation = Date()
        self.dateToDo = dateToDo
        self.text = text
    }
    
}

protocol ElementUpdatedDelegate {
    func elementUpdated(sender: ToDoElement)
}

class ToDoModel {
    private var elements: [ToDoElement] = []
    
    private var delegates: [ElementUpdatedDelegate] = []
    
    private let realm = try! Realm()
    
    private static let model = ToDoModel()
    
    private init()
    {
        try! realm.write({
            elements = realm.objects(ToDoElement.self).map({$0})
        })
    }
    
    static func createToDoModel(delegate: ElementUpdatedDelegate?) -> ToDoModel {
        let model = ToDoModel.model
        if let delegate = delegate {
            model.delegates.append(delegate)
            for element in model.elements {
                element.delegates.append(delegate)
            }
        }
        return model
    }
    
    public func getCurrentTasks() -> [ToDoElement] {

        return elements.filter({element in !element.isDeleted && !element.isDone})
    }
    
    public func getDoneAndDeletedTasks() -> [ToDoElement] {
        return elements.filter({element in element.isDeleted || element.isDone})
    }
    
    public func addTask(element: ToDoElement) {
        try! realm.write({
            realm.add(element)
            elements.append(element)
            element.delegates = delegates
            for elementDelegate in element.delegates {
                elementDelegate.elementUpdated(sender: element)
            }
        })
    }
}
