//
//  CollectionViewCell.swift
//  garbage_calendar
//
//  Created by Norihiko Oba on 2018/02/17.
//  Copyright © 2018年 Norihiko Oba. All rights reserved.
//

import UIKit

class CalendarCollectionViewCell: UICollectionViewCell {
    static let Height: CGFloat = 72
    private let basicFontSize: CGFloat = 19.0
    
    @IBOutlet private weak var dayLabel: UILabel!
    @IBOutlet private weak var iconImageView: GarbageImageView!
    @IBOutlet private weak var circleView: UIView!
    
    override func awakeFromNib() {
        super.awakeFromNib()
    }
    
    func setDateLabelText(_ day: Int) {
        dayLabel.text = String(day)
    }
    
    func setIconImage(imageName: String?) {
        guard let imageName = imageName else {
            return iconImageView.image = nil
        }
        iconImageView.image = UIImage(named: imageName)
    }
    
    func changeDayLabelColor(isToday: Bool, isWeekday: Bool) {
        if isToday {
            return dayLabel.textColor = .main
        }
        if isWeekday {
            dayLabel.textColor = .darkGray
        } else {
            dayLabel.textColor = .lightGray
        }
    }
    
    func changeDateLabelFont(isToday: Bool) {
        let size: CGFloat
        let weight: UIFont.Weight
        if isToday {
            size = basicFontSize + 3
            weight = UIFont.Weight.bold
        } else {
            size = basicFontSize
            weight = UIFont.Weight.regular
        }
        dayLabel.font = UIFont.systemFont(ofSize: size, weight: weight)
    }
    
    func changeBorderColor(isToday: Bool) {
        if isToday {
            contentView.drawCorneredBorder(cornerRadius: 4, borderWidth: 2, borderColor: .main)
            contentView.backgroundColor = UIColor.main.withAlphaComponent(0.05)
            return
        }
        contentView.clearCorneredBorder()
        contentView.backgroundColor = UIColor.white
    }
}
