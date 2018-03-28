//
//  AlarmSetting.swift
//  GarbageCalendarModel
//
//  Created by Norihiko Oba on 2018/03/09.
//  Copyright © 2018年 Norihiko Oba. All rights reserved.
//

import Foundation

public struct AlarmSetting: Codable {
    public var isOn: Bool
    public let alarms: [Alarm]
    
    public init(isOn: Bool, alarms: [Alarm]) {
        self.isOn = isOn
        self.alarms = alarms
    }
}
