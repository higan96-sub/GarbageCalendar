//
//  DateManager.swift
//  GarbageCalendarModel
//
//  Created by Norihiko Oba on 2018/02/22.
//  Copyright © 2018年 Norihiko Oba. All rights reserved.
//

import Foundation
import Timepiece

class DateManager {
    static func datesFor(year: Int, month: Int) -> [Date] {
        var dates = [Date]()
        let firstDateOfMonth = Date(year: year, month: month, day: 1)
        let lastDateOfMonth = firstDateOfMonth.endOfMonth()
        
        guard let firstDate = firstDateOfMonth - (firstDateOfMonth.weekday - 1).day else { return dates }
        guard let lastDate = lastDateOfMonth + (7 - lastDateOfMonth.weekday).day else { return dates }
        
        var date = firstDate
        while date < (lastDate + 1.day)! {
            dates.append(date)
            date = (date + 1.day)!
        }
        return dates
    }
}
