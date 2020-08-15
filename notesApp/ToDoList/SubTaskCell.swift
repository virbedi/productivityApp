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
    
    override func layoutSubviews() {
        
        indexView.backgroundColor = .green
        indexView.text = "1"
        indexView.constrainIn(contentView)
            .fillHeight()
            .width(15)
            .leading()
        
        seperator.backgroundColor = .black
        seperator.constrainIn(contentView)
            .width(1)
            .fillHeight()
            .leading(to:indexView.trailingAnchor)
        
        titleView.text = "Cell"
        titleView.constrainIn(contentView)
            .fillHeight()
            .width(200)
            .leading(to:seperator.trailingAnchor)
        
        
    }
    
    
    
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
    
    // To Make XCode happy
    required init?(coder: NSCoder) { fatalError("init(coder:) has not been implemented") }
    override func awakeFromNib() { super.awakeFromNib() }

}
