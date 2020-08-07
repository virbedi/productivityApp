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
    
    var note: Note?
    public var completion: ((String,String)->Void)?
    
    func setupUI() {
        
        titleField.text = note?.title
        noteField.text = note?.content
        
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        setupUI()
        titleField.becomeFirstResponder()
        
        navigationItem.rightBarButtonItem = UIBarButtonItem(title: "Save", style: .done, target: self, action: #selector(didTapSave))
    }
    
    
    @objc func didTapSave(){
        if let text = titleField.text, !text.isEmpty, !noteField.text.isEmpty{
            completion?(text,noteField.text)
        }
    }


}
