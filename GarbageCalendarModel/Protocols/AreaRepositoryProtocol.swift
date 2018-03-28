//
//  AreaRepositoryProtocol.swift
//  GarbageCalendarModel
//
//  Created by Norihiko Oba on 2018/03/01.
//  Copyright © 2018年 Norihiko Oba. All rights reserved.
//

import Foundation

public protocol AreaRepositoryProtocol {
    func fetchAreas(municipalityId: Int) -> [Area]
}
