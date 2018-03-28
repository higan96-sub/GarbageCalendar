//
//  GarbageCategory.swift
//  GarbageCalendarModel
//
//  Created by Norihiko Oba on 2018/02/28.
//  Copyright © 2018年 Norihiko Oba. All rights reserved.
//

import Foundation

public struct GarbageCategory: Codable {
    public let id: Int
    public let garbageDayId: Int
    public let name: String
    public let imageName: String
}
