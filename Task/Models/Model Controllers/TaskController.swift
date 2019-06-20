//
//  TaskController.swift
//  Task
//
//  Created by Nic Gibson on 6/19/19.
//  Copyright © 2019 Nic Gibson. All rights reserved.
//

import Foundation
import CoreData

class TaskController {
    
    let fetchedResultsController: NSFetchedResultsController<Task>
    
    static let shared = TaskController()
    
    init() {
        let fetchRequest: NSFetchRequest<Task> = Task.fetchRequest()
        fetchRequest.sortDescriptors = [NSSortDescriptor(key: "isComplete", ascending: false), NSSortDescriptor(key: "due", ascending:  false)]
        let resultsController: NSFetchedResultsController<Task> = NSFetchedResultsController(fetchRequest: fetchRequest, managedObjectContext: CoreDataStack.managedObjectContext, sectionNameKeyPath: "isComplete", cacheName: nil)
        
        fetchedResultsController = resultsController
        do {
            try fetchedResultsController.performFetch()
        } catch {
            print("There was an error performing the fetch! \(error.localizedDescription)")
        }
    }
    
    func addTaskWith(name: String, notes: String?, due: Date?) {
        let _ = Task(name: name, due: due, notes: notes)
        saveToPersistentStore()
    }
    
    func update(task: Task, name: String, notes: String?, due: Date?) {
        task.name = name
        task.notes = notes
        task.due = due
        saveToPersistentStore()
    }
    
    func remove(task: Task) {
        
        task.managedObjectContext?.delete(task)
        saveToPersistentStore()
    }
    
    func saveToPersistentStore() {
        let moc = CoreDataStack.managedObjectContext
        do {
            try moc.save()
        } catch {
            print("Error saving to moc: \(error.localizedDescription)")
        }
    }
    
    func toggleIsCompleteFor(task: Task) {
        task.isComplete = !task.isComplete
        saveToPersistentStore()
    }

}
