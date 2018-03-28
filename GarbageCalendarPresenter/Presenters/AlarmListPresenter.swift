//
//  AlarmSettingListPresenter.swift
//  GarbageCalendarPresenter
//
//  Created by Norihiko Oba on 2018/03/08.
//  Copyright © 2018年 Norihiko Oba. All rights reserved.
//

import Foundation
import GarbageCalendarModel

public protocol AlarmListView {
    func reloadTableView()
    func reloadAlarmFlag(_ isOn: Bool)
}

public class AlarmListPresenter {
    private let view: AlarmListView
    private let repository: AlarmSettingRepositoryProtocol
    private let municipality: Municipality
    private var alarmSetting: AlarmSetting
    
    public init(_ view: AlarmListView) {
        self.view = view
        repository = AlarmSettingRepositoryMock()
        let municipalityRepository = MunicipalityRepositoryMock()
        municipality = municipalityRepository.fetch(id: 9999999)!
        alarmSetting = repository.fetchAlarmSetting(municipality: municipality)
        view.reloadAlarmFlag(alarmSetting.isOn)
    }
    
    public func getGarbageDayTypeCount() -> Int {
        if !alarmSetting.isOn { return 0 }
        return alarmSetting.alarms.count
    }
    
    public func getGarbageDayTypeName(index: Int) -> String {
        return alarmSetting.alarms[index].name
    }
    
    public func getAlarmCount(index: Int) -> Int {
        return 999999999
    }
    
    public func getAlarmValue(index: Int) -> String {
        return alarmSetting.alarms[index].getLabel()
    }
    
    public func setAlarmSetting(isOn: Bool) {
        alarmSetting.isOn = isOn
        repository.insertAlarmSetting(alarmSetting)
        view.reloadTableView()
    }
}
