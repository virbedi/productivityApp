//
//  SubTaskCell.swift
//  notesApp
//
//  Created by Vir Bedi on 8/15/20.
//  Copyright © 2020 Vir Bedi. All rights reserved.
//

import UIKit
import constrain
import BEMCheckBox
import RealmSwift

class SubTaskCell: UITableViewCell, BEMCheckBoxDelegate {
    
    weak var subtask: SubTask?
    var indexView = UILabel()
    var titleView = UILabel()
    var seperator = UIView(frame: CGRect(x: 0, y: 0, width: 0.5, height: 10))
    var checkBox = BEMCheckBox()
    

    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)

        checkBox.frame = CGRect(x: 0, y: 0, width: 25, height: 25)
        accessoryView = checkBox
        checkBox.delegate = self
        
    }
    
    public func setupUI(for subtask: SubTask, at index: Int) {
        self.subtask = subtask
        indexView.text = String(index + 1)
        titleView.text = subtask.objective
        checkBox.setOn(subtask.done, animated: false)
        
    }
    
    
    override func layoutSubviews() {
        
        indexView.backgroundColor = .green
        indexView.textAlignment = .center
        indexView.constrainIn(contentView)
            .fillHeight()
            .width(45)
            .leading()
        
        seperator.backgroundColor = .black
        seperator.constrainIn(contentView)
            .width(1)
            .fillHeight(3)
            .leading(to:indexView.trailingAnchor)
        
        titleView.constrainIn(contentView)
            .fillHeight()
            .width(200)
            .leading(to:seperator.trailingAnchor, constant: 5)
        
        
    }
    
    
    
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
        let dict: [String: Any?] = ["done" : selected]
        
        if self.subtask != nil {
            RealmService.shared.update(self.subtask!, with: dict)
        }
        
        
        // Configure the view for the selected state
    }
    
    
    // To Make XCode happy
    required init?(coder: NSCoder) { fatalError("init(coder:) has not been implemented") }
    override func awakeFromNib() { super.awakeFromNib() }

}
