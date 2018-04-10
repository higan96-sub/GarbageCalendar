//
//  MunicipalityRepositoryMock.swift
//  GarbageCalendarModel
//
//  Created by Norihiko Oba on 2018/03/01.
//  Copyright © 2018年 Norihiko Oba. All rights reserved.
//

import Foundation

public class MunicipalityRepositoryMock: MunicipalityRepositoryProtocol {
    public init() {}
    let key = "debug-municipality_key"
    
    public func fetch(id: Int) -> Municipality? {
        var municipality: Municipality?
        let url = Bundle.main.url(forResource: "municipality", withExtension: "json")!
        do {
            let jsonData = try Data(contentsOf: url)
            municipality = try JSONDecoder().decode(Municipality.self, from: jsonData)
        }
        catch {
            print(error)
        }
        return municipality
    }
}
