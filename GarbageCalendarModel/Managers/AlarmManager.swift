//
//  AlarmManager.swift
//  GarbageCalendarModel
//
//  Created by Norihiko Oba on 2018/03/09.
//  Copyright © 2018年 Norihiko Oba. All rights reserved.
//

import Foundation

public class AlarmManager {
    public static let defaultDayInterval: Alarm.DayIntervalType = .zero
    public static let defaultHour = 7
    public static let defaultMinute = 0
    
    static func createAlarms(municipality: Municipality) -> AlarmSetting {
        let alarms = createAlarms(types: municipality.garbageDayTypes)
        let setting = AlarmSetting(isOn: false, alarms: alarms)
        return setting
    }
    
    public static func defaultDate() -> Date {
        return Date(year: 1986, month: 1, day: 28, hour: defaultHour, minute: defaultMinute, second: 00)
    }
}

extension AlarmManager {
    private static func createAlarms(types: [String]) -> [Alarm] {
        var alarms = [Alarm]()
        for type in types {
            let alarm = createAlarm(type: type)
            alarms.append(alarm)
        }
        return alarms
    }
    
    public static func createAlarm(type: String) -> Alarm {
        let alarm = Alarm(name: type, dayInterval: defaultDayInterval.rawValue, hour: defaultHour, minute: defaultMinute)
        return alarm
    }
}

