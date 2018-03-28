//
//  GarbageRepositoryProtocol.swift
//  GarbageCalendarModel
//
//  Created by Norihiko Oba on 2018/02/22.
//  Copyright © 2018年 Norihiko Oba. All rights reserved.
//

import Foundation

public protocol GarbageDayRepositoryProtocol {
    func fetchGarbageDays(year: Int, month: Int) -> [GarbageDay]
    func fetchGarbageDays(from: Date, forDays: Int) -> [GarbageDay]
}
