//
//  GarbageImageView.swift
//  GarbageCalendar
//
//  Created by Norihiko Oba on 2018/03/07.
//  Copyright © 2018年 Norihiko Oba. All rights reserved.
//

import UIKit

extension Notification.Name {
    static let GarbageImageViewDidTouch = Notification.Name("GarbageImageViewNotification")
}

class GarbageImageView: UIImageView {
    public static let UserInfoKey = "categoryId"
    internal var categoryId: Int?
    internal var isCollectionDay = true
    
    override func awakeFromNib() {
        super.awakeFromNib()
        isUserInteractionEnabled = true
    }
    
    override func touchesEnded(_ touches: Set<UITouch>, with event: UIEvent?) {
        if !isCollectionDay { return }
        if let categoryId = categoryId {
            let userInfo = ["categoryId" : categoryId]
            NotificationCenter.default.post(name: .GarbageImageViewDidTouch, object: GarbageDayListViewController.self, userInfo: userInfo)
        }
    }
}
