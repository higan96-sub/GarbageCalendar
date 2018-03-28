//
//  AreaRepositoryMock.swift
//  GarbageCalendarModel
//
//  Created by Norihiko Oba on 2018/03/01.
//  Copyright © 2018年 Norihiko Oba. All rights reserved.
//

import Foundation

public class AreaRepositoryMock: AreaRepositoryProtocol {
    public init() {}
    
    public func fetchAreas(municipalityId: Int) -> [Area] {
        let areas = buildAreas()
        return areas
    }
    
    private func buildAreas() -> [Area] {
        let areas: [Area] = [
            Area(id: 0, municipalityId: 0, name: "北エリア", regions: buildRegions(0)),
            Area(id: 1, municipalityId: 0, name: "南エリア", regions: buildRegions(1)),
            Area(id: 2, municipalityId: 0, name: "西エリア", regions: buildRegions(2)),
            Area(id: 3, municipalityId: 0, name: "東エリア", regions: buildRegions(3))
        ]
        return areas
    }
    
    private func buildRegions(_ areaId: Int) -> [Region] {
        var regions = [Region]()
        for i in 0..<10 {
            let id = areaId * 10 + i
            let region = Region(id: id, areaId: areaId, name: "ブロック" + String(id))
            regions.append(region)
        }
        return regions
    }
}
