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

    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)

        doneIcon.frame = CGRect(x: 0, y: 0, width: 30, height: 30)
        accessoryView = doneIcon
        doneIcon.delegate = self
        
        
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
        
        // Checkmark layout
        
        
        // Title layout
        title.font = UIFont.boldSystemFont(ofSize: 16)
        title.isUserInteractionEnabled = false
        title.constrainIn(contentView)
            .fillHeight()
            .width(200)
            .leading(constant: 16)
        
        if task != nil {
            title.text = task?.objective
        }
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func didTap(_ checkBox: BEMCheckBox) {
        if self.task != nil {
            self.task?.timerCount = 0
            let strikeLabelText =  NSMutableAttributedString(string: task!.objective)
            strikeLabelText.addAttribute(NSAttributedString.Key.strikethroughStyle,
                                                 value: NSUnderlineStyle.single.rawValue,
                                                     range: NSMakeRange(0, strikeLabelText.length))
            title.attributedText = strikeLabelText
            
        }
    }
    
}
