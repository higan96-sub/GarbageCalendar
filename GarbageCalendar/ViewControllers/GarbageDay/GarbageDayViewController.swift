//
//  GarbageDetailViewController.swift
//  GarbageCalendar
//
//  Created by Norihiko Oba on 2018/03/07.
//  Copyright © 2018年 Norihiko Oba. All rights reserved.
//

import UIKit
import PagingMenuController
import DeckTransition

class GarbageDayViewController: UIViewController, DeckTransitionViewControllerProtocol {
    
    var childViewControllerForDeck: UIViewController? {
        let menu = childViewControllers.first as? MenuViewController
        let currentViewController = menu?.pagingViewController?.currentViewController
        return currentViewController
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        navigationItem.largeTitleDisplayMode = .never
        
        title = "garbage_kind_can".localized
        
        guard let pagingMenuController = self.childViewControllers.first as? MenuViewController  else { return }
        let viewControllers = [
            GarbageViewController.instantiate(withStoryboard: "Garbage"),
            GarbageViewController.instantiate(withStoryboard: "Garbage")
        ]
        let options = PagingMenuOptions(viewControllers)
        
        pagingMenuController.setup(options)
    }
}
