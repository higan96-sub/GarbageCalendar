//
//  SingleGarbageCell.swift
//  garbage_calendar
//
//  Created by Norihiko Oba on 2018/02/19.
//  Copyright © 2018年 Norihiko Oba. All rights reserved.
//

import UIKit
import GarbageCalendarModel

class SingleGarbageCell: GarbageCell {
    @IBOutlet private weak var garbageImageView: GarbageImageView!
    @IBOutlet private weak var imageBgView: UIView!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        garbageImageViews = [garbageImageView]
    }
    
    override func setGarbageDay(_ garbageDay: GarbageDay) {
        guard let category = garbageDay.categories.first else { return }
        garbageNameLabel.text = garbageDay.name.localized
        garbageImageViews.first?.isCollectionDay = garbageDay.isCollectionDay
        garbageImageViews.first?.image = UIImage(named: category.imageName)
        garbageImageViews.first?.categoryId = category.id
    }
}
