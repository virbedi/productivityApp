//
//  PomdoroViewController.swift
//  notesApp
//
//  Created by Vir Bedi on 7/28/20.
//  Copyright © 2020 Vir Bedi. All rights reserved.
//

import UIKit
import UserNotifications
import constrain

class PomdoroViewController: UIViewController {

    @IBOutlet var timeSelector: UISegmentedControl!
    @IBOutlet var timeLabel : UILabel!
    let cancelButton = RoundedButton(title: "Cancel")
    let actionButton = RoundedButton(title: "Start")
    
    var currentTimer = 300 // 25 min * 60 sec
    var duration = 300
    var timer = Timer()
    let shapeLayer = CAShapeLayer()
    let trackLayer = CAShapeLayer()
    let basicAnimation = CABasicAnimation(keyPath: "strokeEnd")
    var timerIsOn = false
    

    let notifCenter = UNUserNotificationCenter.current()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        currentTimer = duration
        let timeString = formatTime(currentTimer)
        timeLabel.text = timeString
        
        actionButton.addTarget(self, action: #selector(didTapAction), for: .touchUpInside)
        cancelButton.addTarget(self, action: #selector(didTapCancel), for: .touchUpInside)
        
        actionButton.backgroundColor = .systemBlue
        cancelButton.backgroundColor = .systemBlue
        
        let buttonStack = UIStackView(arrangedSubviews: [cancelButton,actionButton])
        buttonStack.axis = .horizontal
        buttonStack.spacing = 25
        buttonStack.distribution = .fillEqually
        
        constrainSubview(buttonStack)
            .height(50)
            .fillWidth(10)
            .top(to: timeLabel.bottomAnchor, constant: 100)
            
        
//        let center = view.center
//        let circleTop = -CGFloat.pi * 0.5
        // Creating a path and passing it to shape layer for progress circle
//        let circularPath = UIBezierPath(arcCenter: center, radius: 100, startAngle: circleTop, endAngle: 2*CGFloat.pi, clockwise: true)
//
//        shapeLayer.path = circularPath.cgPath
//        shapeLayer.strokeColor = UIColor.red.cgColor
//        shapeLayer.lineWidth = 10
//        shapeLayer.strokeEnd = 0
//        shapeLayer.lineCap = .round
//        shapeLayer.fillColor = UIColor.clear.cgColor
//
//        trackLayer.path = circularPath.cgPath
//        trackLayer.strokeColor = UIColor.lightGray.cgColor
//        trackLayer.lineWidth = 10
//        trackLayer.strokeEnd = 0
//        trackLayer.fillColor = UIColor.clear.cgColor
//
//
//        basicAnimation.toValue = 1
//        basicAnimation.fillMode = .forwards
//        basicAnimation.isRemovedOnCompletion = false
//        shapeLayer.add(basicAnimation, forKey: "key" )
        
        // Notifications Permission
        
        notifCenter.requestAuthorization(options: [.alert, .sound]) {
            (granted, error) in
        }
        
        
    }
    
    @objc func didTapCancel(_ sender: Any) {
        timer.invalidate()
        currentTimer = duration
        let timeString = formatTime(currentTimer)
        timeLabel.text = timeString
        notifCenter.removePendingNotificationRequests(withIdentifiers: ["pomodorNotif"])
        actionButton.setTitle("Start", for: .normal)
    }
    
    @objc func didTapAction(_ sender: Any) {
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
    
    @IBAction func changeDuration(_ sender: UISegmentedControl) {
        timer.invalidate()
        notifCenter.removePendingNotificationRequests(withIdentifiers: ["pomodorNotif"])
        actionButton.setTitle("Start", for: .normal)
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
    
    func toggleTimer(on: Bool ){
        if on {
            
            // Schedule notification
            scheduleNotification(interval: currentTimer)
            
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
    
    func scheduleNotification(interval: Int) {
        let notifDate = Date().addingTimeInterval(TimeInterval(interval))
        let dateComponents = Calendar.current.dateComponents([.year, .month, .day, .hour, .minute, .second], from: notifDate)
        let trigger = UNCalendarNotificationTrigger(dateMatching: dateComponents , repeats: false)
        
        let notifContent = UNMutableNotificationContent()
        notifContent.title = "Notif title"
        notifContent.body = "Good job, your timer is up! Stay Productive!"
        
        let request =  UNNotificationRequest(identifier: "pomodorNotif", content: notifContent, trigger: trigger)
        
        notifCenter.add(request) { (error) in
            print(error as Any)
        }
    }
}
