//
//  Area.swift
//  GarbageCalendarModel
//
//  Created by Norihiko Oba on 2018/03/01.
//  Copyright © 2018年 Norihiko Oba. All rights reserved.
//

import Foundation

public struct Area: Codable {
    public let id: Int
    public let municipalityId: Int
    public let name: String
    public let regions: [Region]
}
