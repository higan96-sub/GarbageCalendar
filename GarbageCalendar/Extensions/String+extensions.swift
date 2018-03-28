//
//  String+extensions.swift
//  GarbageCalendar
//
//  Created by Norihiko Oba on 2018/03/01.
//  Copyright © 2018年 Norihiko Oba. All rights reserved.
//

import Foundation

extension String {
    var localized: String {
        return NSLocalizedString(self, comment: self)
    }
    
    func localized(withTableName tableName: String? = nil, bundle: Bundle = Bundle.main, value: String = "") -> String {
        return NSLocalizedString(self, tableName: tableName, bundle: bundle, value: value, comment: self)
    }
}
