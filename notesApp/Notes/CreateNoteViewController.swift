//
//  CreateNoteViewController.swift
//  notesApp
//
//  Created by Vir Bedi on 7/25/20.
//  Copyright © 2020 Vir Bedi. All rights reserved.
//

import UIKit

class CreateNoteViewController: UIViewController {

    @IBOutlet var titleField: UITextField!
    @IBOutlet var noteField: UITextView!
    @IBOutlet var typeSelector: UISegmentedControl!
    
    var note: Note?
    var noteType = ""
    public var completion: ((String,String,String)->Void)?
    
    func setupUI() {
        
        titleField.text = note?.title
        noteField.text = note?.content
        noteType = note?.type ?? "Note"
        
        switch note?.type {
            case "Note":
                typeSelector.selectedSegmentIndex = 0
            case "List":
                typeSelector.selectedSegmentIndex = 1
            case "Idea":
                typeSelector.selectedSegmentIndex = 2
            case "Work":
                typeSelector.selectedSegmentIndex = 3
            case "Thought":
                typeSelector.selectedSegmentIndex = 4
            default:
               typeSelector.selectedSegmentIndex = 0
        }
        
        
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        setupUI()
        titleField.becomeFirstResponder()
        self.hideKeyboardWhenTappedAround()
        navigationItem.rightBarButtonItem = UIBarButtonItem(title: "Save", style: .done, target: self, action: #selector(didTapSave))
    }
    
    
    @objc func didTapSave(){
        if let text = titleField.text, !text.isEmpty, !noteField.text.isEmpty{
            completion?(text, noteField.text, noteType)
        }
    }
    
    @IBAction func selectType(_ sender: UISegmentedControl) {
        
        var type = "Note"
        let index = sender.selectedSegmentIndex
        switch index {
            case 0:
                type = "Note"
            case 1:
                type = "List"
            case 2:
                type = "Idea"
            case 3:
                type = "Work"
            case 4:
                type = "Thought"
            default:
                type = "Note"
        }
        
        noteType = type
    }

}

extension UIViewController {
    func hideKeyboardWhenTappedAround() {
        let tap: UITapGestureRecognizer = UITapGestureRecognizer(target: self, action: #selector(UIViewController.dismissKeyboard))
        tap.cancelsTouchesInView = false
        view.addGestureRecognizer(tap)
    }

    @objc func dismissKeyboard() {
        view.endEditing(true)
    }
}
