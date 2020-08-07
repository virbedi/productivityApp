//
//  NoteViewController.swift
//  notesApp
//
//  Created by Vir Bedi on 7/25/20.
//  Copyright © 2020 Vir Bedi. All rights reserved.
//

import UIKit

class NoteViewController: UIViewController {

    @IBOutlet var titleLabel: UILabel!
    @IBOutlet var noteLabel: UITextView!
    
    public var noteTitle: String = ""
    public var note: String = ""
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        titleLabel.text = noteTitle
        noteLabel.text = note
        
    }
    
}
