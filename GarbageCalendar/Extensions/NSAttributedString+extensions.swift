//
//  NSAttributedString+extensions.swift
//  GarbageCalendar
//
//  Created by Norihiko Oba on 2018/03/07.
//  Copyright © 2018年 Norihiko Oba. All rights reserved.
//

import Foundation
import UIKit

extension NSAttributedString {
    static func list(stringList: [String], font: UIFont, bullet: String = "\u{2022}", indentation: CGFloat = 16, lineSpacing: CGFloat = 2, paragraphSpacing: CGFloat = 4, textColor: UIColor = .darkGray, bulletColor: UIColor = .darkGray) -> NSAttributedString {
        
        let textAttributes: [NSAttributedStringKey: Any] = [NSAttributedStringKey.font: font, NSAttributedStringKey.foregroundColor: textColor]
        let bulletAttributes: [NSAttributedStringKey: Any] = [NSAttributedStringKey.font: font, NSAttributedStringKey.foregroundColor: bulletColor]
        
        let paragraphStyle = NSMutableParagraphStyle()
        let nonOptions = [NSTextTab.OptionKey: Any]()
        paragraphStyle.tabStops = [NSTextTab(textAlignment: .left, location: indentation, options: nonOptions)]
        paragraphStyle.defaultTabInterval = indentation
        paragraphStyle.lineSpacing = lineSpacing
        paragraphStyle.paragraphSpacing = paragraphSpacing
        paragraphStyle.headIndent = indentation
        
        let bulletList = NSMutableAttributedString()
        for (index, string) in stringList.enumerated() {
            var formattedString = "\(bullet)\t\(string)"
            if index < stringList.count - 1 {
                formattedString = formattedString + "\n"
            }
            let attributedString = NSMutableAttributedString(string: formattedString)
            attributedString.addAttributes([NSAttributedStringKey.paragraphStyle : paragraphStyle],range: NSMakeRange(0, attributedString.length))
            attributedString.addAttributes(textAttributes,range: NSMakeRange(0, attributedString.length))
            let string:NSString = NSString(string: formattedString)
            let rangeForBullet:NSRange = string.range(of: bullet)
            attributedString.addAttributes(bulletAttributes, range: rangeForBullet)
            bulletList.append(attributedString)
        }
        
        return bulletList
    }
}
