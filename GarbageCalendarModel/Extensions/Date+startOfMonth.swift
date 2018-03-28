//
//  Date+startOfMonth.swift
//  GarbageCalendarModel
//
//  Created by Norihiko Oba on 2018/02/21.
//  Copyright © 2018年 Norihiko Oba. All rights reserved.
//

public extension Date {
    func startOfMonth() -> Date {
        return Calendar.current.date(from: Calendar.current.dateComponents([.year, .month], from: Calendar.current.startOfDay(for: self)))!
    }
    
    func endOfMonth() -> Date {
        return Calendar.current.date(byAdding: DateComponents(month: 1, day: -1), to: self.startOfMonth())!
    }
    
    func weekOfMonth() -> Int {
        return Calendar.current.component(.weekOfMonth, from: self)
    }
    
    static func numberOfWeeks(year: Int, month: Int) -> Int {
        let date = Date(year: year, month: month, day: 1)
        let endOfMonth = date.endOfMonth()
        return endOfMonth.weekOfMonth()
    }
}
