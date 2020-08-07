//
//  TaskEntryViewController.swift
//  notesApp
//
//  Created by Vir Bedi on 7/26/20.
//  Copyright © 2020 Vir Bedi. All rights reserved.
//

import UIKit

class TaskEntryViewController: UIViewController,UITextFieldDelegate {

    @IBOutlet var taskLabel: UITextField!
    
    var updateTable: (() -> Void)?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        taskLabel.delegate = self
        
        navigationItem.rightBarButtonItem = UIBarButtonItem(title:"Save", style: .done, target: self, action: #selector(didTapSave))

        // Do any additional setup after loading the view.
    }
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        didTapSave()
        return true
    }
    
    @objc func didTapSave(){
        guard let text = taskLabel.text, !text.isEmpty else {return}
        
        let count = UserDefaults().value(forKey: "count") as? Int
        let newCount = count ?? 0 + 1
        UserDefaults().set(text, forKey: "task_\(newCount)")
        
        updateTable?()
        
        navigationController?.popViewController(animated: true)
    }
}
