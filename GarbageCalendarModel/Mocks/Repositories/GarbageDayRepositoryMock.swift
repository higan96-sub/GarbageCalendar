//
//  GarbageDayRepositoryMock.swift
//  GarbageCalendarModel
//
//  Created by Norihiko Oba on 2018/02/22.
//  Copyright © 2018年 Norihiko Oba. All rights reserved.
//

import Foundation

import Timepiece

public class GarbageDayRepositoryMock: GarbageDayRepositoryProtocol {
    private var calendar: GarbageCalendar?
    
    public init(){
        let url = Bundle.main.url(forResource: "calendar", withExtension: "json")!
        do {
            let jsonData = try Data(contentsOf: url)
            let decoder = JSONDecoder()
            decoder.dateDecodingStrategy = .formatted({
                let f = DateFormatter()
                f.calendar = Calendar(identifier: .gregorian)
                f.locale = .current
                f.dateFormat = "yyyy-MM-dd"
                return f
                }())
            calendar = try decoder.decode(GarbageCalendar.self, from: jsonData)
        }
        catch {
            print(error)
        }
    }
    
    public func fetchGarbageDays(year: Int, month: Int) -> [GarbageDay] {
        var garbageDays = [GarbageDay]()
        guard let calendar = calendar else { return garbageDays }
        let dates = DateManager.datesFor(year: year, month: month)
        guard let first = dates.first else { return garbageDays }
        guard let last = dates.last else { return garbageDays }
        
        garbageDays = calendar.garbageDays.filter { (garbageDay) -> Bool in
            return first <= garbageDay.date && garbageDay.date <= last
        }
        
        return garbageDays
    }
    
    public func fetchGarbageDays(from: Date, forDays: Int) -> [GarbageDay] {
        var garbageDays = [GarbageDay]()
        guard let to = from + forDays.day else { return garbageDays }
        guard let calendar = calendar else { return garbageDays }
        
        garbageDays = calendar.garbageDays.filter { (garbageDay) -> Bool in
            return from <= garbageDay.date && garbageDay.date <= to
        }
        return garbageDays
    }
}
