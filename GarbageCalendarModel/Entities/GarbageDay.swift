//
//  GarbageDay.swift
//  GarbageCalendarModel
//
//  Created by Norihiko Oba on 2018/02/21.
//  Copyright © 2018年 Norihiko Oba. All rights reserved.
//

public struct GarbageDay: Codable {
    public let date: Date
    public let categories: [GarbageCategory]
    public let isCollectionDay: Bool
    public let name: String
    
    public func categoryImageNames() -> [String] {
        if isCollectionDay == false {
            return ["icon_sleep"]
        }
        let categoryImageNames:[String] = self.categories.map { (category) -> String in
            return category.imageName
        }
        return categoryImageNames
    }
    
    public func smallImageName() -> String? {
        if isCollectionDay == false {
            return nil
        }
        return categoryImageNames().first
    }
    
    public func garbages() -> [AnyHashable : Any] {
        let garbages = [AnyHashable : Any]()
        return garbages
    }
}
