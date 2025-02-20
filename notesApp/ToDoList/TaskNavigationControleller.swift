//
//  TaskNavigationControleller.swift
//  notesApp
//
//  Created by Vir Bedi on 8/15/20.
//  Copyright © 2020 Vir Bedi. All rights reserved.
//

import UIKit

class TaskNavigationControleller: UINavigationController {
    override func viewDidLoad() {
        super.viewDidLoad()
        setNavBar()
     }

     func setNavBar() {
        if #available(iOS 13.0, *) {
            let appearance = UINavigationBarAppearance()
            appearance.configureWithOpaqueBackground()
            appearance.backgroundColor = Color.navBar.lightGreen
            navigationController?.navigationBar.tintColor = .white
            self.navigationBar.standardAppearance = appearance
            self.navigationBar.scrollEdgeAppearance = appearance
            
        } else {
            self.navigationBar.barTintColor = UIColor.blue
            self.navigationBar.titleTextAttributes = [.foregroundColor: UIColor.yellow]
        }
      }
}
