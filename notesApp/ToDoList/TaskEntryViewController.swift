//
//  TaskEntryViewController.swift
//  notesApp
//
//  Created by Vir Bedi on 7/26/20.
//  Copyright © 2020 Vir Bedi. All rights reserved.
//

import UIKit

class TaskEntryViewController: UIViewController,UITextFieldDelegate, UITableViewDelegate, UITableViewDataSource {

    @IBOutlet var objective: UITextField!
    @IBOutlet var details: UITextField!
    @IBOutlet var dateTime: UIDatePicker!
    
    weak var task: Task?
    var subtasks = [SubTask]()
    
    let subtaskTable = UITableView()
    
    let newSubtaskText = UITextField()
    let addSubtaskButton = RoundedButton(title: "Add")
    
    public var completion: ((String, String, Date, [SubTask]) -> Void)?
    
    func setupUI(for GivenTask: Task) {
        task = GivenTask
        if task != nil {
            objective.text = task?.objective
            details.text = task?.details
            subtasks.append(contentsOf: task!.subTasks)
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        dateTime.isHidden = true
        subtaskTable.reloadData()
        subtaskTable.rowHeight = 50
        // Save button
        navigationItem.rightBarButtonItem = UIBarButtonItem(title:"Save",
                                                            style: .done,
                                                            target: self,
                                                            action: #selector(didTapSave))
        // Task Description
        objective.tintColor = .systemBlue
        details.tintColor = .systemBlue
        
        // Add Subtask Text View and Button
        newSubtaskText.borderStyle = .roundedRect
        newSubtaskText.placeholder = "New Subtask"
        newSubtaskText.tintColor = .systemBlue
        newSubtaskText.rightView = addSubtaskButton
        
        newSubtaskText.rightViewMode = .always
        addSubtaskButton.addTarget(self, action: #selector(didTapAddSubtask), for: .touchUpInside)
        addSubtaskButton.backgroundColor = .blue
        
        // SubtaskTable
        subtaskTable.register(SubTaskCell.self, forCellReuseIdentifier: "SubTaskCell")
        subtaskTable.delegate = self
        subtaskTable.dataSource = self
        
        
        
        constrainSubview(newSubtaskText)
            .fillWidth(5)
            .height(50)
            .top(to: details.bottomAnchor, constant: 5)
        
        constrainSubview(subtaskTable)
        .fillWidth()
        .height(600)
            .top(to: newSubtaskText.bottomAnchor, constant: 5)
        
        
        
    }
    // MARK: Subtask Table Stuff
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return subtasks.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = subtaskTable.dequeueReusableCell(withIdentifier: "SubTaskCell", for: indexPath) as! SubTaskCell
        cell.setupUI(for: subtasks[indexPath.row], at: indexPath.row)
        return cell
    }
    
    func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == .delete {
            subtasks.remove(at: indexPath.row)
            subtaskTable.reloadData()
        }
    }
    
    @objc func didTapAddSubtask(){
        if newSubtaskText.text != nil {
            let newTask = SubTask((newSubtaskText.text!), done: false)
            subtasks.append(newTask)
            subtaskTable.reloadData()
        }
        newSubtaskText.text = ""
    }
    
    @objc func didTapSave(){
        
        if let objectiveText = objective.text {
            let detailText = details.text ?? ""
            let dateTimeValue = dateTime.date
            completion?(objectiveText, detailText, dateTimeValue, subtasks)
        }
        
        
    }
    
}

