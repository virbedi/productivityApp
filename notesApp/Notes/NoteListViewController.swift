//
//  ViewController.swift
//  notesApp
//
//  Created by Vir Bedi on 7/25/20.
//  Copyright © 2020 Vir Bedi. All rights reserved.
//

import UIKit
import RealmSwift


class NoteListViewController: UIViewController, UITableViewDataSource, UITableViewDelegate {
    
    //Components
    @IBOutlet var table : UITableView!
    @IBOutlet var emptyTitle : UILabel!
   
    var currentIndex = 0
    var models: Results<Note>!
    var notifToken: NotificationToken?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        table.delegate = self
        table.dataSource = self
      
        navigationItem.title = "Notes"
        
        table.register(NoteTableViewCell.self, forCellReuseIdentifier: "customCell")
        table.rowHeight = 75
        
        table.separatorStyle = .none
        let realm = RealmService.shared.realm
        models = realm.objects(Note.self)
        
        // Hiding the empty title if the model contains notes
        if models.count > 0 {
            self.emptyTitle.isHidden = true
            self.table.isHidden = false
        }
        
        // Reloading table for new entry
        table.reloadData()
        
        // Catching any realm errors
        notifToken = realm.observe{(notification, realm) in
            self.table.reloadData()
        }
        RealmService.shared.observeRealmErrors(in: self) { (error) in
            print(error ?? "That's strange, no error!")
        }
        
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        //Stop Realm observer
        notifToken?.invalidate()
    }
    
    
    
    @IBAction func addNewNote(){
        guard let vc = storyboard?.instantiateViewController(identifier: "createNoteVC") as? CreateNoteViewController else {return}
        vc.title = "New Note"
        vc.navigationItem.largeTitleDisplayMode = .never
        
        vc.completion = { noteTitle, note, type in
            let today = Date()
            let formatter = DateFormatter()
                formatter.timeStyle = .short
                formatter.dateStyle = .medium
            let dateTime = formatter.string(from: today)
            let newNote = Note(title: noteTitle, content: note, loc: nil, date: dateTime, type: type)
            RealmService.shared.create(newNote)
           
            self.emptyTitle.isHidden = true
            self.table.isHidden = false
            
            self.navigationController?.popToRootViewController(animated: true)
            
        }
        navigationController?.pushViewController(vc, animated: true)
    }
    
    //MARK: Note Table
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return models.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "customCell", for: indexPath) as! NoteTableViewCell
        cell.note = models[indexPath.row]
        cell.callLayout()
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
        tableView.deselectRow(at: indexPath, animated: true)

        let vc = (storyboard?.instantiateViewController(withIdentifier: "createNoteVC")) as! CreateNoteViewController
        let index = indexPath.row
        vc.note = models[indexPath.row]
        
        vc.completion =  { noteTitle, note, type in
            let dict: [String: Any?] = ["title": noteTitle, "content": note, "type": type]
            RealmService.shared.update(self.models[index], with: dict)
            self.navigationController?.popToRootViewController(animated: true)
        }
        navigationController?.pushViewController(vc, animated: true)
    }
    
    func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == .delete {
            let note = models[indexPath.row]
            RealmService.shared.delete(note)
        }
    }
}
