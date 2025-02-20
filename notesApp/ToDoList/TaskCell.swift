//
//  TaskCell.swift
//  notesApp
//
//  Created by Vir Bedi on 8/9/20.
//  Copyright © 2020 Vir Bedi. All rights reserved.
//

import UIKit
import constrain
import BEMCheckBox

class TaskCell: UITableViewCell, BEMCheckBoxDelegate {
    weak var task: Task?
    var title = UILabel()
    var dateTime = UILabel()
    var doneIcon = BEMCheckBox()
    var subtaskImage = UIImageView()
    var subtaskFraction = UILabel()
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)

        doneIcon.frame = CGRect(x: 0, y: 0, width: 30, height: 30)
        accessoryView = doneIcon
        doneIcon.delegate = self
        
    }
    
    public func setupCell(with task: Task) {
        self.task = task
        title.text = task.objective
        dateTime.text = task.date
        doneIcon.setOn(task.done, animated: false)
        layoutSubviews()
    }
    
    override var frame: CGRect {
        get {
            return super.frame
        }
        set {
            let xInset: CGFloat = 10
            let yInset: CGFloat = 5
            var frame = newValue
            frame.origin.x += xInset
            frame.origin.y += yInset
            frame.size.width -= 2 * xInset
            frame.size.height -= 2 * yInset
            super.frame = frame
        }
    }

    
    
    override func layoutSubviews() {

        // Cell rounding and shadow
        backgroundColor = .clear
        self.layer.masksToBounds = false
        self.layer.shadowOpacity = 0.25
        self.layer.shadowRadius = 5
        self.layer.shadowOffset = CGSize(width: 0, height: 2)
        self.layer.shadowColor = UIColor.black.cgColor
        self.backgroundColor = .white
        self.layer.cornerRadius = 8
        
        
        // Title layout
        title.font = UIFont.boldSystemFont(ofSize: 16)
        title.isUserInteractionEnabled = false
        title.constrainIn(contentView)
            .fillHeight()
            .width(200)
            .leading(constant: 16)
        
        //Subtask value
        let subtasks = task?.subTasks ?? nil
        if subtasks != nil && subtasks?.count != 0 {
            
            let image = UIImage(named: "subtaskIcon")
            subtaskImage.image = image
            subtaskFraction.text = progressValue()
            subtaskFraction.font = UIFont(name: "Avenir-Light", size: 12.0)
            
            let stack = UIStackView(arrangedSubviews: [subtaskImage,subtaskFraction])
            stack.distribution = .fillEqually
            
            stack.constrainIn(contentView)
                .leading(to: title.trailingAnchor, constant: 20)
                .width(40)
                .top(30)
        }
        
        
        
        
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func didTap(_ checkBox: BEMCheckBox) {
        
        if self.task != nil {
            
            let oldValue = self.task?.done ?? false
            
            // Update new value in database
            let dict: [String: Any?] = ["done" : !oldValue]
            RealmService.shared.update(self.task!, with: dict)
            
        }
    }
    
    func updateTitle(value: Bool) {
        // Work in progress
        if value {
            
            let attributeString: NSMutableAttributedString =  NSMutableAttributedString(string: task!.objective)
            
            attributeString.addAttribute(NSAttributedString.Key.strikethroughStyle, value: 0.5, range: NSMakeRange(0, attributeString.length))
            
            title.attributedText = attributeString
        }
        else {
            title.attributedText = NSMutableAttributedString(string: "")
            title.text = task?.objective
        }
    }
    
    func progressValue() -> String {
        // Returns "completed/total" for subtasks
        guard let subtasks = task?.subTasks else { return "Error counting value"}
        let totalSubtasks = subtasks.count
        
        var completedSubtasks = 0
        
        for subtask in subtasks {
            if subtask.done {
                completedSubtasks += 1
            }
        }
        
        return("\(completedSubtasks)/\(totalSubtasks)")
    }
    
}
