//
//  AppDelegate.swift
//  garbage_calendar
//
//  Created by Norihiko Oba on 2018/02/16.
//  Copyright © 2018年 Norihiko Oba. All rights reserved.
//

import UIKit
import DropDown
import UserNotifications

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {

    var window: UIWindow?

    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplicationLaunchOptionsKey: Any]?) -> Bool {
        UIBarButtonItem.appearance().tintColor = .main
        DropDown.appearance().textColor = UIColor.darkText
        DropDown.appearance().textFont = UIFont.systemFont(ofSize: 20)
        DropDown.appearance().backgroundColor = UIColor.white
        DropDown.appearance().selectionBackgroundColor = UIColor.lightGray
        DropDown.appearance().cellHeight = 56
//        UserDefaults.standard.removeObject(forKey: "debug-my_region")
        
        return true
    }

    func applicationWillResignActive(_ application: UIApplication) {
        
    }

    func applicationDidEnterBackground(_ application: UIApplication) {
        
    }

    func applicationWillEnterForeground(_ application: UIApplication) {
        let garbagesViewController = getGarbagesViewController()
        garbagesViewController?.reload()
        UIApplication.shared.applicationIconBadgeNumber = 0
    }

    func applicationDidBecomeActive(_ application: UIApplication) {
    }

    func applicationWillTerminate(_ application: UIApplication) {
    }
}

extension AppDelegate {
    private func getGarbagesViewController() -> GarbageDayListViewController? {
        return (window?.rootViewController as? UINavigationController)?.visibleViewController as? GarbageDayListViewController
    }
}
