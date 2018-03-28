//
//  DayIntervalPickerPresenter.swift
//  GarbageCalendarPresenter
//
//  Created by Norihiko Oba on 2018/03/09.
//  Copyright © 2018年 Norihiko Oba. All rights reserved.
//

import Foundation
import GarbageCalendarModel

public protocol DayIntervalPickerView {
    func showDataPicker(types: [Alarm.DayIntervalType])
    func setDayIntervalType(type: Alarm.DayIntervalType)
    func dismiss()
}

public class DayIntervalPickerPresenter {
    private var view: DayIntervalPickerView
    private var types: [Alarm.DayIntervalType]
    
    public init(_ view: DayIntervalPickerView) {
        self.view = view
        types = Alarm.DayIntervalType.allValues()
    }
    
    public func getDayIntervalType(index: Int) -> Alarm.DayIntervalType {
        return types[index]
    }
    
    public func getDayIntervalTypeCount() -> Int {
        return types.count
    }
    
    public func setType(index: Int) {
        let type = types[index]
        view.setDayIntervalType(type: type)
    }
}
