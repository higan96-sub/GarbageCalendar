//
//  UIButton+extensions.swift
//  GarbageCalendar
//
//  Created by Norihiko Oba on 2018/03/06.
//  Copyright © 2018年 Norihiko Oba. All rights reserved.
//

import Foundation
import UIKit

extension UIView {
    func drawCorneredRect(cornerRadius: CGFloat = 4.0) {
        self.layer.masksToBounds = true
        self.layer.cornerRadius = cornerRadius
    }
    
    func clearCorneredRect() {
        clearCorneredBorder()
    }
    
    func drawCorneredBorder(cornerRadius: CGFloat = 4.0, borderWidth: CGFloat = 1.0, borderColor: UIColor = UIColor.darkGray) {
        self.layer.masksToBounds = true
        self.layer.cornerRadius = cornerRadius
        self.layer.borderWidth = borderWidth
        self.layer.borderColor = borderColor.cgColor
    }
    
    func clearCorneredBorder() {
        self.layer.masksToBounds = false
        self.layer.cornerRadius = 0.0
        self.layer.borderWidth = 0.0
        self.layer.borderColor = UIColor.clear.cgColor
    }
    
    func drawCircle(width: CGFloat? = nil) {
        let circleWidth: CGFloat
        if let width = width {
            circleWidth = width
        } else {
            circleWidth = self.bounds.width
        }
        self.layer.cornerRadius =  circleWidth / 2
        self.layer.masksToBounds = true
    }
    
    func clearCircle() {
        clearCorneredBorder()
    }
}
