//
//  Alarm.swift
//  GarbageCalendarModel
//
//  Created by Norihiko Oba on 2018/03/09.
//  Copyright © 2018年 Norihiko Oba. All rights reserved.
//

import Foundation

public struct Alarm: Codable {
    public let name: String
    public let dayInterval: Int
    public let hour: Int
    public let minute: Int
    
    public func dayIntervalType() -> DayIntervalType? {
        let type = DayIntervalType(rawValue: dayInterval)
        return type
    }
    
    public func dayIntervalLabel() -> String {
        guard let type = self.dayIntervalType() else { return "" }
        return DayIntervalType.getLabel(type: type)
    }
    
    public func getLabel() -> String {
        let formatter = DateFormatter()
        formatter.setTemplate(.time)
        guard let tmpDate = Date.today().changed(hour: self.hour, minute: self.minute) else { return "-" }
        return dayIntervalLabel() + " - " + formatter.string(from: tmpDate)
    }
}

extension Alarm {
    public enum DayIntervalType: Int {
        case zero = 0
        case oneDay = 1
        case twoDays = 2
        case threeDays = 3
        case fourDays = 4
        case fiveDays = 5
        case sixDays = 6
        case oneWeek = 7
        
        public static func allValues() -> [DayIntervalType] {
            let types: [DayIntervalType] = [.zero,.oneDay,.twoDays,.threeDays,.fourDays,.fiveDays,.sixDays,.oneWeek]
            return types
        }
        
        public static func getLabel(type: DayIntervalType) -> String {
            let day = String(type.rawValue)
            let label: String
            switch type {
            case .zero:
                label = NSLocalizedString("the_day", comment: "")
            case .oneDay, .twoDays, .threeDays ,.fourDays, .fiveDays,.sixDays:
                label = day + NSLocalizedString("days_before", comment: "")
            case .oneWeek:
                label = NSLocalizedString("a_week_before", comment: "")
            }
            return label
        }
    }
}
