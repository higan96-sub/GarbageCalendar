//
//  AlarmEditPresenter.swift
//  GarbageCalendarPresenter
//
//  Created by Norihiko Oba on 2018/03/09.
//  Copyright © 2018年 Norihiko Oba. All rights reserved.
//

import Foundation
import GarbageCalendarModel

public protocol AlarmEditView {
    func showGarbageTypePicker(types: [String])
    func showDayIntervalPicker(types: [Alarm.DayIntervalType])
    func showTimePicker(date: Date)
}

public class AlarmEditPresenter {
    private let view: AlarmEditView
    private let alarm: Alarm?
    
    public init(view: AlarmEditView, alarm: Alarm?) {
        self.view = view
        self.alarm = alarm
    }
    
    public func didGarbageTypeCellTapped() {
        let municipality = MunicipalityRepositoryMock().fetch(id: 9999999)!
        view.showGarbageTypePicker(types: municipality.garbageDayTypes)
    }
    
    public func didDayIntervalCellTapped() {
        view.showDayIntervalPicker(types: Alarm.DayIntervalType.allValues())
    }
    
    public func didTimeCellTapped() {
        view.showTimePicker(date: AlarmManager.defaultDate())
    }
}
