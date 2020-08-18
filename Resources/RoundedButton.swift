//
//  RoundedButton.swift
//  notesApp
//
//  Created by Vir Bedi on 8/17/20.
//  Copyright © 2020 Vir Bedi. All rights reserved.
//

import Foundation
import UIKit

public class RoundedButton: UIButton {
    
    public init(title: String = "") {
        super.init(frame: CGRect.zero)
        
        if title != "" { setTitle(title, for: .normal) }
        contentEdgeInsets = UIEdgeInsets(top: 8, left: 16, bottom: 8, right: 16)
        sizeToFit()
        layer.cornerRadius = frame.height / 2
    }
    
    override public func layoutSubviews() {
        super.layoutSubviews()
        
        layer.cornerRadius = frame.height / 2
    }
    
    required init?(coder: NSCoder) {fatalError("init(coder:) has not been implemented")}
}
