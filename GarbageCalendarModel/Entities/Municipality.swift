//
//  Municipality.swift
//  GarbageCalendarModel
//
//  Created by Norihiko Oba on 2018/03/01.
//  Copyright © 2018年 Norihiko Oba. All rights reserved.
//

import Foundation

public struct Municipality: Codable {
    public let id: Int
    public let version: String
    public let name: String
    public var areas: [Area]
    public let garbageDayTypes: [String]
    
    public func allRegions() -> [Region] {
        var regions = [Region]()
        for area in areas {
            regions += area.regions
        }
        return regions
    }
    
    public func getRegions(for areaName: String? = nil) -> [Region] {
        guard let areaName = areaName else {
            return allRegions()
        }
        let filteredAreas = areas.filter { (area) -> Bool in
            return area.name == areaName
        }
        guard let area = filteredAreas.first else { return [Region]() }
        return area.regions
    }
    
    public func searchRegion(with regionName: String) -> Region? {
        for area in self.areas {
            if let region = searchRegion(in: area, with: regionName) {
                return region
            }
        }
        return nil
    }
}

extension Municipality {
    private func searchRegion(in area: Area, with regionName: String) -> Region? {
        let regions = area.regions.filter({ (region) -> Bool in
            return region.name == regionName
        })
        return regions.first
    }
}
