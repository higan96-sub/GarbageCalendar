//
//  CalendarPresenter.swift
//  GarbageCalendarPresenter
//
//  Created by Norihiko Oba on 2018/02/22.
//  Copyright © 2018年 Norihiko Oba. All rights reserved.
//

import Foundation
import GarbageCalendarModel
import Timepiece

public protocol CalendarView {
    func setGarbageDayDictionary(_ garbageDayDictionary: [[GarbageDay]], yearMonth: String, month: Int)
    func setCalenadarMenu(labels: [String], monthes: [Date], selectedRow: Int?)
}

public class CalendarPresenter {
    private let view: CalendarView
    private let repository: GarbageDayRepositoryProtocol
    private let formatter = DateFormatter()
    
    public init(_ view: CalendarView) {
        self.view = view
        repository = GarbageDayRepositoryMock()
        formatter.setTemplate(.yearMonth)
    }
    
    public func getGarbageCalnderData(month: Date) {
        getGarbageCalnderData(year: month.year, month: month.month)
    }
    
    public func getGarbageCalnderData(year: Int, month: Int) {
        let garbageDays = repository.fetchGarbageDays(year: year, month: month)
        var garbageDayDictionary: [[GarbageDay]] = Array(repeating: [GarbageDay](), count: garbageDays.count / 7)
        
        for (index, garbageDay) in garbageDays.enumerated() {
            let weekIndex = index / 7
            garbageDayDictionary[weekIndex].append(garbageDay)
        }
        let yearMonth = Date(year: year, month: month, day: 1)
        let yearMonthString = formatter.string(from: yearMonth)
        view.setGarbageDayDictionary(garbageDayDictionary, yearMonth: yearMonthString, month: month)
    }
    
    public func getCalendarMenuItems() {
        let today = Date.today()
        let monthes = buidMonthList(from: today)
        let labels = monthes.flatMap({ (date) -> String? in
            formatter.string(from: date)
        })
        let selectedRow = labels.index(of: formatter.string(from: today))
        view.setCalenadarMenu(labels: labels, monthes: monthes, selectedRow: selectedRow)
    }
}

extension CalendarPresenter {
    private func buidMonthList(from today: Date) -> [Date] {
        let startYear: Int
        if today.month < 4 {
            startYear = today.year - 1
        } else {
            startYear = today.year
        }
        let startMonth = Date(year: startYear, month: 4, day: 1)
        var monthes = [startMonth]
        for i in 1...11 {
            guard let nextMonth = startMonth + i.month else { continue }
            monthes.append(nextMonth)
        }
        return monthes
    }
}
