//
//  TaskListVC.swift
//  notesApp
//
//  Created by Vir Bedi on 8/12/20.
//  Copyright © 2020 Vir Bedi. All rights reserved.
//

import UIKit

class TaskListVC: UIViewController, UITableViewDataSource, UITableViewDelegate {
    
    @IBOutlet var tableView: UITableView!
        var tasks = [String]()
        
        override func viewDidLoad() {
            super.viewDidLoad()
            self.title = "Tasks"
            //Get saved tasks
            tableView.delegate = self
            tableView.dataSource = self
            
            //Setup
            if !UserDefaults().bool(forKey: "setup") {
                UserDefaults().set(true,forKey: "setup")
                UserDefaults().set(0, forKey: "count")
            }
            
            updateTasks()
            
        }
        func updateTasks() {
            guard let count = UserDefaults().value(forKey: "count") as? Int else {return}
            
            tasks.removeAll()
            for i in 0..<count {
                if let task =  UserDefaults().value(forKey: "task_\(i+1)") as? String {
                    tasks.append(task)
                }
            }
            tableView.reloadData()
        }
        
        @IBAction func didTapAdd() {
           guard let vc = storyboard?.instantiateViewController(identifier: "TaskEntry") as? TaskEntryViewController else {return}
            vc.title = "New Task"
            navigationController?.pushViewController(vc,animated: true)
            
        }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return tasks.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath)
        cell.textLabel?.text = tasks[indexPath.row]
        
        return cell
    }

}


