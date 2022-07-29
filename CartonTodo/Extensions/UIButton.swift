//
//  UIButton.swift
//  CartonTodo
//
//  Created by ohhyung kwon on 28/7/2022.
//

import UIKit

extension UIButton{

    /// fill button with accent color
    func filled(){
        tintColor = .white
        backgroundColor = UIColor.accentColor
        layer.cornerRadius = 5
        
        contentEdgeInsets = UIEdgeInsets(top: 10, left: 0, bottom: 10, right: 0)
    }
}
