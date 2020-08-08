//
//  CellTableViewCell.swift
//  notesApp
//
//  Created by Vir Bedi on 8/7/20.
//  Copyright © 2020 Vir Bedi. All rights reserved.
//

import UIKit
import constrain


class CellTableViewCell: UITableViewCell {
    
    weak var note: Note?
    var typeImage = UIImageView()
    var title = UITextView()
    var location = UITextView()
    var date = UITextView()
    

    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        
        // Cell image
        typeImage.constrainIn(contentView)
            .fillHeight(5)
            .leading(constant: 10)
        
        // Cell title
        title.isUserInteractionEnabled = false
        title.isSelectable = false
        title.constrainIn(contentView)
            .top(constant: 10)
            .height(25)
            .width(150)
            .leading(to: typeImage.trailingAnchor, constant: 5)
        
        // Location and Date stack
        let detailStack = UIStackView(arrangedSubviews: [date,location])
        detailStack.isUserInteractionEnabled = false
        detailStack.constrainIn(contentView)
            .top(to: title.bottomAnchor, constant: 5)
            .leading(to: typeImage.trailingAnchor, constant: 5)
            .width(100)
    }
    func callLayout(){
        layoutSubviews()
    }
   
    override func layoutSubviews() {
        super.layoutSubviews()
        
        if note != nil {
            title.text = note?.title
            location.text = note?.location
            date.text = note?.date
        }
        let cellImage: UIImage!
        switch note?.type {
            case "Note":
                 cellImage = noteIcons.note
            case "List":
                 cellImage = noteIcons.list
            case "Idea":
                 cellImage = noteIcons.idea
            case "Work":
                 cellImage = noteIcons.work
            case "Thought":
                 cellImage = noteIcons.thought
            default:
                cellImage = noteIcons.note
        }
        typeImage.image = cellImage

       
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
