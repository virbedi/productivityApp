//
//  PomdoroViewController.swift
//  notesApp
//
//  Created by Vir Bedi on 7/28/20.
//  Copyright © 2020 Vir Bedi. All rights reserved.
//

import UIKit

class PomdoroViewController: UIViewController {

    @IBOutlet var timeLabel : UILabel!
    @IBOutlet var cancelButton : UIButton!
    @IBOutlet var actionButton : UIButton!
    
    var time = 1500 // 25 min * 60 sec
    override func viewDidLoad() {
        super.viewDidLoad()

        
    }
    
    @IBAction func didTapCancel(_ sender: Any) {
        
    }
    @IBAction func didTapAction(_ sender: Any) {
        
    }
    
    func formatTime()->String {
        let minutes = Int(time)/60 % 60
        let seconds = Int(time) % 60
        let display = String(format:"%02i:%02i",minutes,seconds)
        
        return display
    }
}
