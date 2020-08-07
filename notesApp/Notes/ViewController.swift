//
//  ViewController.swift
//  notesApp
//
//  Created by Vir Bedi on 7/25/20.
//  Copyright © 2020 Vir Bedi. All rights reserved.
//

import UIKit
import RealmSwift

class ViewController: UIViewController, UITableViewDataSource, UITableViewDelegate {
    
    //Database
    //let realm = try! Realm()
    
    //Components
    @IBOutlet var table : UITableView!
    @IBOutlet var emptyTitle : UILabel!
    var currentIndex = 0
    var models: Results<Note>!
    var notifToken: NotificationToken?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        table.delegate = self
        table.dataSource = self
        title = "Notes"
        
        let realm = RealmService.shared.realm
        models = realm.objects(Note.self)
        
        // Hiding the empty title if the model contains notes
        if models.count > 0 {
            self.emptyTitle.isHidden = true
            self.table.isHidden = false
        }
        
        table.reloadData()
        // Reloading table for new entry
        notifToken = realm.observe{(notification, realm) in
            self.table.reloadData()
        }
        
        // Catching any realm errors
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
        guard let vc = storyboard?.instantiateViewController(identifier: "new") as? CreateNoteViewController else {return}
        vc.title = "New Note"
        vc.navigationItem.largeTitleDisplayMode = .never
        
        vc.completion = { noteTitle,note in
            let today = Date().string(format: ("MM-dd-yyyy"))
            let newNote = Note(title: noteTitle, content: note, loc: nil, date: today)
            RealmService.shared.create(newNote)
            
            self.table.reloadData()
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
        let cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath)
        cell.textLabel?.text = models[indexPath.row].title
        cell.detailTextLabel?.text = models[indexPath.row].content
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
        currentIndex = indexPath.row
        let note = models[currentIndex]
        
        performSegue(withIdentifier: "showNote", sender: note)
        

    }
    
    func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == .delete {
            let note = models[indexPath.row]
            RealmService.shared.delete(note)
            table.reloadData()
        }
    }
    
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "showNote" {
            let destinationVC = segue.destination as! CreateNoteViewController
            destinationVC.note = sender as? Note
            destinationVC.completion =  { noteTitle,note in
                let dict: [String: Any?] = ["title": noteTitle,
                                            "content": note]
                RealmService.shared.update(self.models[self.currentIndex], with: dict)
                self.table.reloadData()
                self.emptyTitle.isHidden = true
                self.table.isHidden = false
                self.navigationController?.popToRootViewController(animated: true)
            }
            
        }
    }

}
extension Date {
    func string(format: String) -> String {
        let formatter = DateFormatter()
        formatter.dateFormat = format
        return formatter.string(from: self)
    }
}
