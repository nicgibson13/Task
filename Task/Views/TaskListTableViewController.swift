//
//  TaskListTableViewController.swift
//  Task
//
//  Created by Nic Gibson on 6/20/19.
//  Copyright © 2019 Nic Gibson. All rights reserved.
//

import UIKit
import CoreData

class TaskListTableViewController: UITableViewController, ButtonTableViewCellDelegate {
    
    func buttonCellButtonTapped(_ sender: ButtonTableViewCell) {
        guard let indexPath = tableView.indexPath(for: sender) else {return}
        let task = TaskController.shared.fetchedResultsController.object(at: indexPath)
        TaskController.shared.toggleIsCompleteFor(task: task)
    }
    

    override func viewDidLoad() {
        super.viewDidLoad()
    }

    // MARK: - Table view data source

    override func numberOfSections(in tableView: UITableView) -> Int {
        return TaskController.shared.fetchedResultsController.sections?.count ?? 1
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        guard let sections = TaskController.shared.fetchedResultsController.sections else {
            fatalError("No sections in fetchedResultsController")
        }
        
        return sections[section].objects?.count ?? 0
//        return TaskController.shared.fetchedResultsController.fetchedObjects?.count ?? 0
    }

    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: "taskCell", for: indexPath) as? ButtonTableViewCell,
         let task = TaskController.shared.fetchedResultsController.fetchedObjects?[indexPath.row] else {return UITableViewCell()}
        cell.update(withTask: task)
        cell.delegate = self
        cell.textLabel?.text = task.name
        
        // Configure the cell...

        return cell
    }

    override func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        if TaskController.shared.fetchedResultsController.sections?[section].name == "0" {
            return "Incompleted"
        } else {
            return "Completed"
        }
    }
    
    /*
    // Override to support conditional editing of the table view.
    override func tableView(_ tableView: UITableView, canEditRowAt indexPath: IndexPath) -> Bool {
        // Return false if you do not want the specified item to be editable.
        return true
    }
    */

    // Override to support editing the table view.
    override func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == .delete {
            guard let task = TaskController.shared.fetchedResultsController.fetchedObjects?[indexPath.row] else {return}
            TaskController.shared.remove(task: task)
        }
    }
    
    /*
    // Override to support rearranging the table view.
    override func tableView(_ tableView: UITableView, moveRowAt fromIndexPath: IndexPath, to: IndexPath) {

    }
    */

    /*
    // Override to support conditional rearranging of the table view.
    override func tableView(_ tableView: UITableView, canMoveRowAt indexPath: IndexPath) -> Bool {
        // Return false if you do not want the item to be re-orderable.
        return true
    }
    */

    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "toDetailView" {
            guard let indexPath = tableView.indexPathForSelectedRow,
                let destinationVC = segue.destination as? TaskDetailTableViewController else {return}
            let task = TaskController.shared.fetchedResultsController.fetchedObjects?[indexPath.row]
            destinationVC.taskLandingPad = task
        }
    }
}
