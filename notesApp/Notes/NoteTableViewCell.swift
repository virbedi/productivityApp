//
//  CellTableViewCell.swift
//  notesApp
//
//  Created by Vir Bedi on 8/7/20.
//  Copyright © 2020 Vir Bedi. All rights reserved.
//

import UIKit
import constrain


class NoteTableViewCell: UITableViewCell {
    
    weak var note: Note?
    var typeImage = UIImageView()
    var title = UILabel()
    var location = UILabel()
    var date = UILabel()
    var cell = UIView()
    

    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        //addEdgesAndShadows()
        
        backgroundColor = .clear // very important
        cell.layer.masksToBounds = false
        cell.layer.shadowOpacity = 0.23
        cell.layer.shadowRadius = 8
        cell.layer.shadowOffset = CGSize(width: 2, height: 5)
        cell.layer.shadowColor = UIColor.black.cgColor

        // add corner radius on `contentView`
        cell.backgroundColor = .white
        cell.layer.cornerRadius = 8
        
        cell.constrainIn(contentView)
            .fill(constant: 8)
        // Cell image
        typeImage.constrain.size(width: 40, height: 40)
        typeImage.constrainIn(cell)
            .fillHeight(10)
            .leading(constant: 15)
        
        // Cell title
        title.font = UIFont.boldSystemFont(ofSize: 16)
        title.isUserInteractionEnabled = false
        title.constrainIn(cell)
            .top(constant: 10)
            .height(20)
            .width(200)
            .leading(to: typeImage.trailingAnchor, constant: 10)
        
        // Date view
        date.font = UIFont.systemFont(ofSize: 12)
        
        date.textAlignment = .left
        date.isUserInteractionEnabled = false
        date.constrainIn(cell)
            .top(to: title.bottomAnchor)
            .leading(to: typeImage.trailingAnchor, constant: 10)
            .height(20)
            .width(150)
        
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
        date.sizeToFit()
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
    
    private func addEdgesAndShadows(){
        cell.layer.cornerRadius = 5
        cell.clipsToBounds = true
        
    
          // Shadows
        let shadowLayer = CAShapeLayer()
        shadowLayer.path = UIBezierPath(roundedRect: bounds, cornerRadius: 5).cgPath
        //shadowLayer.fillColor = UIColor.clear.cgColor
        shadowLayer.shadowColor = UIColor.black.cgColor
        shadowLayer.shadowPath = shadowLayer.path
        shadowLayer.shadowOffset = CGSize(width: 2, height: 5)
        shadowLayer.shadowOpacity = 0.2
        shadowLayer.shadowRadius = 5
        cell.layer.insertSublayer(shadowLayer, at: 0)
          
          // Rasterizing for performance
          cell.layer.shouldRasterize = true
          cell.layer.rasterizationScale = UIScreen.main.scale
      }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
