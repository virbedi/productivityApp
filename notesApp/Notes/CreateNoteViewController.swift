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
    public var completion: ((String,String)->Void)?
    
    init(title: String, content: String){
        
        self.titleField.text = title
        self.noteField.text = content
        super.init(nibName: nil, bundle: nil)
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        
        titleField.becomeFirstResponder()
        
        navigationItem.rightBarButtonItem = UIBarButtonItem(title: "Save", style: .done, target: self, action: #selector(didTapSave))
    }
    
    
    @objc func didTapSave(){
        if let text = titleField.text, !text.isEmpty, !noteField.text.isEmpty{
            completion?(text,noteField.text)
        }
    }
    
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

}
