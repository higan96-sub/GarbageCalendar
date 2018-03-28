//
//  PagingMenuOptions.swift
//  GarbageCalendar
//
//  Created by Norihiko Oba on 2018/03/07.
//  Copyright © 2018年 Norihiko Oba. All rights reserved.
//

import UIKit
import PagingMenuController

struct PagingMenuOptions: PagingMenuControllerCustomizable {
    struct MenuItem: MenuItemViewCustomizable {
        private let title: String
        
        var displayMode: MenuItemDisplayMode {
            let font = UIFont.systemFont(ofSize: 20)
            let title = MenuItemText(text: self.title, selectedColor: .accent, font: font, selectedFont: font)
            return .text(title: title)
        }
        
        init(title: String) {
            self.title = title
        }
    }
    
    struct MenuOptions: MenuViewCustomizable {
        var itemsOptions: [MenuItemViewCustomizable] {
            return [MenuItem(title: "カン"), MenuItem(title: "なべ類")]
        }
        
        var displayMode: MenuDisplayMode {
            return .segmentedControl
        }
        
        var focusMode: MenuFocusMode {
            return .underline(height: 4.0, color: .accent, horizontalPadding: 0.0, verticalPadding: 0)
        }
        
        var height: CGFloat {
            return 56
        }
    }
    
    private let pagingViewControllers: [UIViewController]
    
    var componentType: ComponentType {
        return .all(menuOptions: MenuOptions(), pagingControllers: pagingViewControllers)
    }
    
    init(_ pagingViewControllers: [UIViewController]) {
        self.pagingViewControllers = pagingViewControllers
    }
}
