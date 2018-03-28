//
//  StartSettingPresenter.swift
//  GarbageCalendarPresenter
//
//  Created by Norihiko Oba on 2018/03/01.
//  Copyright © 2018年 Norihiko Oba. All rights reserved.
//

import Foundation
import GarbageCalendarModel

public protocol StartSettingView {
    func setRegionTitle(title: String)
    func setAreaLabels(labels: [String])
    func setRegionLabels(labels: [String])
    func dismiss()
}

public class StartSettingPresenter {
    private let municipalityRepository: MunicipalityRepositoryProtocol
    private let regionRepository: RegionRepositoryProtocol
    private let view: StartSettingView
    private let municipality: Municipality
    
    public init(_ view: StartSettingView, municipalityId: Int) {
        municipalityRepository = MunicipalityRepositoryMock()
        regionRepository = RegionRepositoryMock()
        municipality = municipalityRepository.fetch(id: municipalityId)!
        self.view = view
        if let myRegion = regionRepository.fetchMyRegion() {
            view.setRegionTitle(title: myRegion.name)
        }
    }
    
    public func getAreas() {
        let labels = municipality.areas.map { (area) -> String in
            return area.name
        }
        view.setAreaLabels(labels: labels)
    }
    
    public func getRegions(for areaName: String? = nil) {
        let regions = municipality.getRegions(for: areaName)
        let labels = regionsToLabels(regions)
        view.setRegionLabels(labels: labels)
    }
    
    public func getMyRegion() -> Region? {
        return regionRepository.fetchMyRegion()
    }
    
    public func setMyRegion(_ regionName: String) {
        if let myRegion = municipality.searchRegion(with: regionName) {
            regionRepository.insertMyRegion(myRegion)
        }
        view.dismiss()
    }
}

extension StartSettingPresenter {
    private func regionsToLabels(_ regions: [Region]) -> [String] {
        let labels = regions.map { (region) -> String in
            return region.name
        }
        return labels
    }
}
