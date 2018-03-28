//
//  GarbageCell.swift
//  GarbageCalendar
//
//  Created by Norihiko Oba on 2018/02/28.
//  Copyright © 2018年 Norihiko Oba. All rights reserved.
//

import UIKit
import GarbageCalendarModel

class GarbageCell: UITableViewCell {
    
    @IBOutlet internal weak var garbageNameLabel: UILabel!
    @IBOutlet private weak var bgView: UIView!
    @IBOutlet private weak var bgBottomView: UIView!
    
    internal var garbageImageViews: [GarbageImageView] = [GarbageImageView]()
    public static let imageBgViewCornerRadius: CGFloat = 4
    public static let imageBgViewBackgroundColor = UIColor.white
    
    override func awakeFromNib() {
        super.awakeFromNib()
        garbageNameLabel.textColor = .white
        bgView.backgroundColor = .white
    }
    
    internal func setColor(isToday: Bool) {
        if isToday {
            return self.setMainColor()
        }
        self.setBasicColor()
    }
    
    internal func setGarbageDay(_ garbageDay: GarbageDay) {
        // override me
    }
    
    final internal func setImageView(backgroundColor: UIColor) {
        for garbageImageView in garbageImageViews {
            garbageImageView.backgroundColor = backgroundColor
        }
    }
}

extension GarbageCell {
    private func setMainColor() {
        bgView.drawCorneredBorder(cornerRadius: 8, borderWidth: 4, borderColor: .main)
        bgView.backgroundColor = .white
        bgBottomView.backgroundColor = UIColor.main
        garbageNameLabel.textColor = .white
        setImageView(backgroundColor: .clear)
    }
    
    private func setBasicColor() {
        bgView.drawCorneredBorder(cornerRadius: 8, borderWidth: 4, borderColor: .darkGray)
        bgBottomView.backgroundColor = .darkGray
        bgView.backgroundColor = .bgGray
        garbageNameLabel.textColor = .white
        setImageView(backgroundColor: .clear)
    }
}
