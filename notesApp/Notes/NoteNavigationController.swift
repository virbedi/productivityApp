//
//  NoteNavigationController.swift
//  notesApp
//
//  Created by Vir Bedi on 8/17/20.
//  Copyright © 2020 Vir Bedi. All rights reserved.
//

import UIKit

class NoteNavigationControleller: UINavigationController {
    override func viewDidLoad() {
        super.viewDidLoad()
        setNavBar()
     }

     func setNavBar() {
        if #available(iOS 13.0, *) {
            let appearance = UINavigationBarAppearance()
            appearance.configureWithOpaqueBackground()
            appearance.backgroundColor = Color.navBar.purple
            
//            appearance.titleTextAttributes = [.foregroundColor: UIColor.yellow]
            self.navigationBar.prefersLargeTitles = true
            self.navigationBar.standardAppearance = appearance
            self.navigationBar.scrollEdgeAppearance = appearance
            self.navigationBar.compactAppearance = appearance
        } else {
            self.navigationBar.barTintColor = UIColor.blue
            self.navigationBar.titleTextAttributes = [.foregroundColor: UIColor.yellow]
        }
      }
}
