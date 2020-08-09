//
//  File.swift
//  notesApp
//
//  Created by Vir Bedi on 7/30/20.
//  Copyright © 2020 Vir Bedi. All rights reserved.
//

import Foundation
import RealmSwift

@objcMembers class Note: Object {
    
    dynamic var title: String = ""
    dynamic var content: String = ""
    dynamic var location: String? = nil
    dynamic var date: String = ""
    dynamic var type: String = ""
    
    convenience init(title: String, content: String, loc: String?, date: String, type: String = "Note"){
        self.init()
        self.title = title
        self.content = content
        self.location = loc
        self.date = date
        self.type = type
    }
    
}
