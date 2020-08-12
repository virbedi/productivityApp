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
    dynamic var timerCount: Int = -1
    
    convenience init(_ obj: String, done: Bool, timerCount: Int = -1) {
        self.init()
        self.objective = obj
        self.done = done
        self.timerCount = timerCount
    }
}

@objcMembers class Task: Object {
    
    dynamic var objective: String = ""
    dynamic var details: String = ""
    dynamic var location: String? = nil
    dynamic var date: String = ""
    dynamic var type: String = ""
    dynamic var subTasks = List<SubTask>()
    dynamic var timerCount: Int = -1
    
    convenience init(objective: String, details: String, loc: String?, date: String, type: String = "Note", timerCount: Int = -1) {
        self.init()
        self.objective = objective
        self.details = details
        self.location = loc
        self.date = date
        self.type = type
        self.timerCount = timerCount
    }
    
}
