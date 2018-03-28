//
//  AlarmSettingRepositoryMock.swift
//  GarbageCalendarModel
//
//  Created by Norihiko Oba on 2018/03/08.
//  Copyright © 2018年 Norihiko Oba. All rights reserved.
//

import Foundation

public class AlarmSettingRepositoryMock: AlarmSettingRepositoryProtocol {
    private let key = "debug-alarmSetting"
    
    public init() {}
    
    public func fetchAlarmSetting(municipality: Municipality) -> AlarmSetting {
        guard let storedData = UserDefaults.standard.value(forKey: key) as? Data else {
            return createAlarmSetting(from: municipality)
        }
        if let storedSetting = try? PropertyListDecoder().decode(AlarmSetting.self, from: storedData) {
            return storedSetting
        }
        return createAlarmSetting(from: municipality)
    }
    
    public func insertAlarmSetting(_ setting: AlarmSetting) {
        UserDefaults.standard.set(try? PropertyListEncoder().encode(setting), forKey: key)
    }
    
    public func clerAlarmSetting() {
        UserDefaults.standard.removeObject(forKey: key)
    }
}

extension AlarmSettingRepositoryMock {
    private func createAlarmSetting(from municipality: Municipality) -> AlarmSetting {
        let setting = AlarmManager.createAlarms(municipality: municipality)
        insertAlarmSetting(setting)
        return setting
    }
}
