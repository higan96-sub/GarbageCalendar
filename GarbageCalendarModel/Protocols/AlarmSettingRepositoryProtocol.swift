//
//  AlarmSettingRepositoryProtocol.swift
//  GarbageCalendarModel
//
//  Created by Norihiko Oba on 2018/03/08.
//  Copyright © 2018年 Norihiko Oba. All rights reserved.
//

import Foundation

public protocol AlarmSettingRepositoryProtocol {
    func insertAlarmSetting(_ setting: AlarmSetting)
    func fetchAlarmSetting(municipality: Municipality) -> AlarmSetting
    func clerAlarmSetting()
}
