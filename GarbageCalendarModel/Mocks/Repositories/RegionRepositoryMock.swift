//
//  RegionRepositoryMock.swift
//  GarbageCalendarModel
//
//  Created by Norihiko Oba on 2018/03/01.
//  Copyright © 2018年 Norihiko Oba. All rights reserved.
//

import Foundation

public class RegionRepositoryMock: RegionRepositoryProtocol {
    private let key = "debug-my_region"
    public init() {}
    
    public func fetchMyRegion() -> Region? {
        guard let data = UserDefaults.standard.value(forKey:key) as? Data else {
            return nil
        }
        let region = try? PropertyListDecoder().decode(Region.self, from: data)
        return region
    }
    
    public func insertMyRegion(_ myRegion: Region) {
        UserDefaults.standard.set(try? PropertyListEncoder().encode(myRegion), forKey:key)
    }
}
