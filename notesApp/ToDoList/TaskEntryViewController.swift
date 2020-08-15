//
//  TaskEntryViewController.swift
//  notesApp
//
//  Created by Vir Bedi on 7/26/20.
//  Copyright © 2020 Vir Bedi. All rights reserved.
//

import UIKit

class TaskEntryViewController: UIViewController,UITextFieldDelegate {

//    self.objective = objective
//    self.details = details
//    self.location = loc
//    self.date = date
//    self.type = type
//    self.timerCount = timerCount
    
    @IBOutlet var objective: UITextField!
    @IBOutlet var details: UITextField!
    @IBOutlet var dateTime: UIDatePicker!
    
    weak var task: Task?
    
    let reminderLabel = UILabel()
    let reminderStack = UIStackView()
    let subtaskTable = UITableView()
    
    public var completion: ((String, String, Date) -> Void)?
    
    public func setupUI(for GivenTask: Task) {
        task = GivenTask
        if task != nil {
            objective.text = task?.objective
            details.text = task?.details
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Save button
        navigationItem.rightBarButtonItem = UIBarButtonItem(title:"Save",
                                                            style: .done,
                                                            target: self,
                                                            action: #selector(didTapSave))

        // SubtaskTable
        
    }
    
    @objc func didTapSave(){
        
        if let objectiveText = objective.text {
            let detailText = details.text ?? ""
            let dateTimeValue = dateTime.date
            completion?(objectiveText, detailText, dateTimeValue)
        }
        
        //navigationController?.popViewController(animated: true)
    }
}
