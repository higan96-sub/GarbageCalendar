 //
//  GarbagesPresenter.swift
//  GarbageDayListPresenter
//
//  Created by Norihiko Oba on 2018/02/22.
//  Copyright © 2018年 Norihiko Oba. All rights reserved.
//

import Foundation
import GarbageCalendarModel

public protocol GarbageDayListView {
    func transitionToRegionSetting()
    func transitionToAlarmSetting()
    func transitionToAbout()
    func reloadMenu()
    func presentWalkthrough()
}

public class GarbageDayListPresenter {
    private var garbageDays = [GarbageDay]()
    private let garbageDayRepository: GarbageDayRepositoryProtocol
    private let regionRepository: RegionRepositoryProtocol
    private let alarmSettingRepository: AlarmSettingRepositoryProtocol
    private let view: GarbageDayListView
    private let formatter = DateFormatter()
    private let municipality: Municipality?
    
    public init(view: GarbageDayListView) {
        self.view = view
        garbageDayRepository = GarbageDayRepositoryMock()
        regionRepository = RegionRepositoryMock()
        alarmSettingRepository = AlarmSettingRepositoryMock()
        let municipalityRepository = MunicipalityRepositoryMock()
        municipality = municipalityRepository.fetch(id: 999999)
        formatter.setTemplate(.date)
    }
    
    public func getGarbageDays(from: Date, forDays: Int) {
        garbageDays = garbageDayRepository.fetchGarbageDays(from: from, forDays: forDays)
    }
    
    public func getGarbageDay(index: Int) -> GarbageDay {
        return garbageDays[index]
    }
    
    public func getGarbageDaysCount() -> Int {
        return garbageDays.count
    }
    
    public func getGarbageDayName(index: Int) -> String {
        return garbageDays[index].name
    }
    
    public func getGarbageCategories(index: Int) -> [GarbageCategory] {
        return garbageDays[index].categories
    }
    
    public func getDateString(fromDate: Date, toDay: Int) -> String? {
        guard let date = Calendar.current.date(byAdding: .day, value: toDay, to: fromDate) else { return nil }
        return formatter.string(from: date)
    }
    
    public func doMenuAction(kind: SettingMenu.Kind) {
        switch kind {
        case .about:
            view.transitionToAbout()
        case .alarm:
            view.transitionToAlarmSetting()
        case .region:
            view.transitionToRegionSetting()
        }
    }
    
    public func getSettingValue(for kind: SettingMenu.Kind) -> String? {
        let myRegion = regionRepository.fetchMyRegion()
        switch kind{
        case .about:
            return nil
        case .region:
            return myRegion?.name
        case .alarm:
            guard let municipality = municipality else { return nil }
            if alarmSettingRepository.fetchAlarmSetting(municipality: municipality).isOn {
                return NSLocalizedString("enabled", comment: "")
            }
            return NSLocalizedString("disabled", comment: "")
        }
    }
    
    public func showWalkthrough() {
        let myRegion = regionRepository.fetchMyRegion()
        if myRegion == nil {
            view.presentWalkthrough()
        }
    }
    
    public func isListReloadable(_ reloadedAt: Date?) -> Bool {
        let myRegion = regionRepository.fetchMyRegion()
        if myRegion == nil {
            return false
        }
        guard let reloadedAt = reloadedAt else {
            return true
        }
        if reloadedAt < Date.today() {
            return true
        }
        return false
    }
}
