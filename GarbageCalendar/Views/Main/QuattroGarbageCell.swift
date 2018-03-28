//
//  QuattroGarbageCell.swift
//  GarbageCalendar
//
//  Created by Norihiko Oba on 2018/02/28.
//  Copyright © 2018年 Norihiko Oba. All rights reserved.
//

import UIKit
import GarbageCalendarModel

class QuattroGarbageCell: GarbageCell {
    
    @IBOutlet weak var topLeftImageBgView: UIView!
    @IBOutlet weak var topLeftImageView: GarbageImageView!
    @IBOutlet weak var topRightImageBgView: UIView!
    @IBOutlet weak var topRightImageView: GarbageImageView!
    @IBOutlet weak var bottomLeftImageBgView: UIView!
    @IBOutlet weak var bottomLeftImageView: GarbageImageView!
    @IBOutlet weak var bottomRightImageBgView: UIView!
    @IBOutlet weak var bottomRightImageView: GarbageImageView!
    
    private var imageBgViews = [UIView]()
    
    override func awakeFromNib() {
        super.awakeFromNib()
        imageBgViews = [topLeftImageBgView, topRightImageBgView, bottomLeftImageBgView, bottomRightImageBgView]
        garbageImageViews = [topLeftImageView, topRightImageView, bottomLeftImageView, bottomRightImageView]
    }
    
    override func setGarbageDay(_ garbageDay: GarbageDay) {
        garbageNameLabel.text = garbageDay.name.localized
        for (i, category) in zip(garbageDay.categories.indices, garbageDay.categories) {
            garbageImageViews[i].image = UIImage(named: category.imageName)
            garbageImageViews[i].categoryId = category.id
            garbageImageViews[i].isCollectionDay = garbageDay.isCollectionDay
            if (i == garbageImageViews.count) {
                break
            }
        }
    }
}
