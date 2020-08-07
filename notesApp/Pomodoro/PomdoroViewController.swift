//
//  PomdoroViewController.swift
//  notesApp
//
//  Created by Vir Bedi on 7/28/20.
//  Copyright © 2020 Vir Bedi. All rights reserved.
//

import UIKit

class PomdoroViewController: UIViewController {

    @IBOutlet var timeSelector: UISegmentedControl!
    @IBOutlet var timeLabel : UILabel!
    @IBOutlet var cancelButton : UIButton!
    @IBOutlet var actionButton : UIButton!
    
    var currentTimer = 300 // 25 min * 60 sec
    var duration = 300
    var timer = Timer()
    
    var timerIsOn = false
    
    func toggleTimer(on: Bool ){
        if on {
            timer  = Timer.scheduledTimer(withTimeInterval: 1, repeats: true, block: { [weak self](_) in
                // This is a completion handler and will fire every "timeInterval"
                guard let strongSelf = self else { return }
                strongSelf.currentTimer -= 1
                let timeString = strongSelf.formatTime(strongSelf.currentTimer)
                if strongSelf.currentTimer != 0 {
                    strongSelf.timeLabel.text = timeString
                }
                else if strongSelf.currentTimer == 0 {
                    // Timer hit 0 so do whatever you'd like to do here
            
                    strongSelf.timeLabel.text = timeString
                    strongSelf.timer.invalidate()
                }
                else {
                    fatalError()
                }
            })
        }
        else {
            timer.invalidate()
        }
        
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        currentTimer = duration
        let timeString = formatTime(currentTimer)
        timeLabel.text = timeString
        
    }
    
    @IBAction func didTapCancel(_ sender: Any) {
        timer.invalidate()
        currentTimer = duration
        let timeString = formatTime(currentTimer)
        timeLabel.text = timeString
        
        actionButton.setTitle("Start", for: .normal)
    }
    @IBAction func didTapAction(_ sender: Any) {
        timerIsOn.toggle()
        if timerIsOn {
            actionButton.setTitle("Pause", for: .normal)
        } else {
            actionButton.setTitle("Start", for: .normal)
        }
        toggleTimer(on: timerIsOn)
    }
    
    func formatTime(_ timeString: Int)->String {
        
        let minutes = Int(timeString)/60 % 60
        let seconds = Int(timeString) % 60
        let display = String(format:"%02i:%02i",minutes,seconds)
        
        return display
    }
    
    @IBAction func switchTimer(_ sender: UISegmentedControl) {
        timer.invalidate()
        let index = sender.selectedSegmentIndex
        if index == 0{
            duration = 5 * 60
        } else if index == 1 {
            duration = 10 * 60
        } else if index == 2 {
            duration = 15 * 60
        } else {
            duration = 1500
        }
        currentTimer = duration
        let timeString = formatTime(currentTimer)
        timeLabel.text = timeString
        
    }
}
