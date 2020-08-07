//
//  RealmService.swift
//  notesApp
//
//  Created by Vir Bedi on 8/5/20.
//  Copyright © 2020 Vir Bedi. All rights reserved.
//

import Foundation
import RealmSwift

class RealmService {
    
    private init() {}
    // This will be our singleton
    static let shared = RealmService()
    
    var realm = try! Realm()
    
    func create<T: Object>(_ object: T){
        do{
            try realm.write{
                realm.add(object)
            }
            
        } catch {
            post(error)
        }
    }
    
    func update<T: Object>(_ object: T, with dict: [String: Any?]){
        do{
            try realm.write{
                for (key, value) in dict {
                    object.setValue(value, forKey: key)
                }
            }
            
        } catch {
            post(error)
        }
    }
    
    func delete<T: Object>(_ object: T){
        do{
            try realm.write{
                realm.delete(object)
            }
            
        } catch {
            post(error)
        }
    }
    
    func post(_ error: Error){
        NotificationCenter.default.post(name: NSNotification.Name("Realm Error"), object: error)
    }
    
    func observeRealmErrors(in vc: UIViewController, completion: @escaping (Error?) -> Void){
        NotificationCenter.default.addObserver(forName: NSNotification.Name("Realm Error"),
                                               object: nil,
                                               queue: nil) { (notification) in completion(notification.object as? Error)}
    }
    
    func stopObserver(in vc: UIViewController){
        NotificationCenter.default.removeObserver(vc, name: NSNotification.Name("Realm Error"), object: nil)
    }
}
