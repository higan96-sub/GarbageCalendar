//
//  UIColor+AppDefined.swift
//  garbage_calendar
//
//  Created by Norihiko Oba on 2018/02/18.
//  Copyright © 2018年 Norihiko Oba. All rights reserved.
//

import UIKit

extension UIColor {
    convenience public init(rgba: Int64) {
        let r = CGFloat((rgba & 0xFF000000) >> 24) / 255.0
        let g = CGFloat((rgba & 0x00FF0000) >> 16) / 255.0
        let b = CGFloat((rgba & 0x0000FF00) >>  8) / 255.0
        let a = CGFloat( rgba & 0x000000FF)        / 255.0
        
        self.init(red: r, green: g, blue: b, alpha: a)
    }
    
    class var main: UIColor {
        return UIColor(rgba: 0xDE6641FF)
    }
    
    class var accent: UIColor {
        return UIColor.main
    }
    
    class var bgGray: UIColor {
        return UIColor(rgba: 0xF2F2F2FF)
    }
    
    class var superLightGray: UIColor {
        return UIColor(rgba: 0xE9E9E9FF)
    }
}
