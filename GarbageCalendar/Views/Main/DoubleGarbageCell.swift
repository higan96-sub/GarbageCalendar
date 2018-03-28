//
//  DoubleGarbageCell.swift
//  GarbageCalendar
//
//  Created by Norihiko Oba on 2018/02/28.
//  Copyright © 2018年 Norihiko Oba. All rights reserved.
//

import UIKit
import GarbageCalendarModel

class DoubleGarbageCell: GarbageCell {
    
    @IBOutlet private weak var leftImageBgView: UIView!
    @IBOutlet private weak var leftImageView: GarbageImageView!
    @IBOutlet private weak var rightImageBgView: UIView!
    @IBOutlet private weak var rightImageView: GarbageImageView!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        garbageImageViews = [leftImageView, rightImageView]
    }
    
    override func setGarbageDay(_ garbageDay: GarbageDay) {
        garbageNameLabel.text = garbageDay.name.localized
        let categories = garbageDay.categories
        if categories.count != garbageImageViews.count { return }
        for (i, garbageImageView) in garbageImageViews.enumerated() {
            garbageImageView.image = UIImage(named: categories[i].imageName)
            garbageImageView.categoryId = categories[i].id
            garbageImageView.isCollectionDay = garbageDay.isCollectionDay
        }
    }
}
