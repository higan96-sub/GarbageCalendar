//
//  DateFormatter+SetTemplate.swift
//  GarbageCalendarPresenter
//
//  Created by Norihiko Oba on 2018/02/22.
//  Copyright © 2018年 Norihiko Oba. All rights reserved.
//

import Foundation

extension DateFormatter {
    // テンプレートの定義
    public enum Template: String {
        case date = "MMddEEEE"     // 1/1日曜日
        case yearMonth = "yM"
        case time = "Hm"     // 12:39:22
        case full = "yMdkHms" // 2017/1/1 12:39:22
        case onlyHour = "k"   // 17時
        case era = "GG"       // "西暦" (default) or "平成" (本体設定で和暦を指定している場合)
        case weekDay = "EEEE" // 日曜日
    }
    
    public func setTemplate(_ template: Template) {
        dateFormat = DateFormatter.dateFormat(fromTemplate: template.rawValue, options: 0, locale: .current)
    }
}
