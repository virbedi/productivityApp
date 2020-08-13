//
//  Task.swift
//  notesApp
//
//  Created by Vir Bedi on 8/8/20.
//  Copyright © 2020 Vir Bedi. All rights reserved.
//

import Foundation
import RealmSwift

@objcMembers class SubTask: Object {
    dynamic var objective: String = ""
    dynamic var done: Bool = false
    
    convenience init(_ obj: String, done: Bool) {
        self.init()
        self.objective = obj
        self.done = done
    }
}

@objcMembers class Task: Object {
    
    dynamic var objective: String = ""
    dynamic var details: String = ""
    dynamic var location: String? = nil
    dynamic var date: String = ""
    dynamic var type: String = ""
    dynamic var subTasks = List<SubTask>()
    
    convenience init(objective: String, details: String, loc: String?, date: String, type: String = "Note") {
        self.init()
        self.objective = objective
        self.details = details
        self.location = loc
        self.date = date
        self.type = type
    }
    
}
