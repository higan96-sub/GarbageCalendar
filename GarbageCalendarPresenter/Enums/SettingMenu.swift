//
//  SettingMenu.swift
//  GarbageCalendarPresenter
//
//  Created by Norihiko Oba on 2018/02/22.
//  Copyright © 2018年 Norihiko Oba. All rights reserved.
//

import Foundation

public struct SettingMenu {
    public static let items: [SettingMenu.Kind]  = [.region, .alarm, .about]
    
    public enum Kind: Int {
        case region = 0
        case alarm = 1
        case about = 2
    }
    
    public static func labels() -> [String] {
        var labels = [String]()
        for kind in self.items {
            let label = self.getLabel(kind)
            labels.append(label)
        }
        return labels
    }
    
    public static func getLabel(_ kind: SettingMenu.Kind) -> String {
        switch kind {
        case .region:
            return NSLocalizedString("setting-menu-kind_region", comment: "")
        case .alarm:
            return NSLocalizedString("setting-menu-kind_alarm", comment: "")
        case .about:
            return NSLocalizedString("setting-menu-kind_about", comment: "")
        }
    }
}
