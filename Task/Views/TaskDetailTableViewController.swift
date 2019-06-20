//
//  TaskDetailTableViewController.swift
//  Task
//
//  Created by Nic Gibson on 6/19/19.
//  Copyright © 2019 Nic Gibson. All rights reserved.
//

import UIKit

class TaskDetailTableViewController: UITableViewController {
    
    var taskLandingPad: Task? {
        didSet {
            updateViews()
        }
    }
    var dueDateValue: Date?
    
    @IBOutlet var dueDatePicker: UIDatePicker!
    @IBOutlet weak var taskNameTextField: UITextField!
    @IBOutlet weak var taskDueTextField: UITextField!
    @IBOutlet weak var taskNotesTextView: UITextView!
    override func viewDidLoad() {
        super.viewDidLoad()
        updateViews()
        taskDueTextField.inputView = dueDatePicker
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        tableView.reloadData()
    }
    
    @IBAction func saveButtonTapped(_ sender: Any) {
        guard let name = taskNameTextField?.text,
            let notes = taskNotesTextView?.text else {return}
        if let task = taskLandingPad {
                TaskController.shared.update(task: task, name: name, notes: notes, due: dueDateValue)
            } else {
                TaskController.shared.addTaskWith(name: name, notes: notes, due: dueDateValue)
            }
            navigationController?.popViewController(animated: true)
        }
    
    @IBAction func datePickerValueChanged(_ sender: UIDatePicker) {
        taskDueTextField.text = dueDatePicker.date.stringValue()
    }
    
    @IBAction func userTappedView(_ sender: UITapGestureRecognizer) {
        taskNameTextField.resignFirstResponder()
        taskDueTextField.resignFirstResponder()
        taskNotesTextView.resignFirstResponder()
    }
    
    
    @IBAction func cancelButtonTapped(_ sender: Any) {
        navigationController?.popViewController(animated: true)
    }
    func updateViews() {
        guard let due = taskLandingPad?.due else {return}
        if isViewLoaded {
            taskNameTextField.text = taskLandingPad?.name
            taskDueTextField.text = due.stringValue()
            taskNotesTextView.text = taskLandingPad?.notes
        }
    }
}
