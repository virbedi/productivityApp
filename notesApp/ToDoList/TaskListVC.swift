//
//  TaskListVC.swift
//  notesApp
//
//  Created by Vir Bedi on 8/12/20.
//  Copyright © 2020 Vir Bedi. All rights reserved.
//

import UIKit
import RealmSwift

class TaskListVC: UIViewController, UITableViewDataSource, UITableViewDelegate {
    
    @IBOutlet var table: UITableView!
    var tasks = [Task]()
    var models: Results<Task>!
    var notifToken: NotificationToken?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.title = "Tasks"
        
        table.delegate = self
        table.dataSource = self
        
        table.register(TaskCell.self, forCellReuseIdentifier: "TaskCell")
        table.rowHeight = 75
        
        table.separatorStyle = .none
        
        let realm = RealmService.shared.realm
        models = realm.objects(Task.self)
        
        // Hiding the empty title if the model contains notes
        if models.count > 0 {
            
        }
        
        // Reloading table for new entry
        updateTasks()
        
        // Catching any realm errors
        notifToken = realm.observe{(notification, realm) in
            self.updateTasks()
        }
        RealmService.shared.observeRealmErrors(in: self) { (error) in
            print(error ?? "That's strange, no error!")
        }
        
        
    }
    func updateTasks() {
        let count = models.count
        
        tasks.removeAll()
        
        for i in 0..<count {
            let task =  models[i]
            tasks.append(task)
        }
        table.reloadData()
    }
    
    @IBAction func didTapAdd() {
//        guard let vc = storyboard?.instantiateViewController(identifier: "TaskEntry") as? TaskEntryViewController else {return}
        let vc = TaskEntryViewController() 
        vc.title = "New Task"
        
        vc.completion = { obj, det, date, subtasks in
            
            let newTask = Task(objective: obj, details: det, date: "")
            newTask.subTasks.append(objectsIn: subtasks)
            RealmService.shared.create(newTask)
        
            self.navigationController?.popToRootViewController(animated: true)
        }
        navigationController?.pushViewController(vc,animated: true)
        
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
        
        
        let vc = TaskEntryViewController() 
        
        vc.setupUI(for: tasks[indexPath.row])
        
        // Updating subtask on completion
        vc.completion = { obj, det, date, subtasks in
            let dict: [String: Any?] = ["objective": obj,
                                        "details": det,
                                        "date": "",
                                        "subTasks": subtasks]
            RealmService.shared.update(self.tasks[indexPath.row], with: dict)
            self.navigationController?.popToRootViewController(animated: true)
        }
        
        navigationController?.pushViewController(vc, animated: true)
        
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return tasks.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell = tableView.dequeueReusableCell(withIdentifier: "TaskCell", for: indexPath) as! TaskCell
        cell.setupCell(with: tasks[indexPath.row])
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == .delete {
            let task = models[indexPath.row]
            RealmService.shared.delete(task)
        }
    }
    
}


