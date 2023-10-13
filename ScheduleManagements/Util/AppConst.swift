//
//  AppConst.swift
//  ScheduleManagements
//
//  Created by 柿崎逸 on 2023/10/12.
//

import Foundation

// MARK: - AppConst
enum AppConst {
    enum Text {
        static let monday = "月"
        static let tuesday = "火"
        static let wednesday = "水"
        static let thursday = "木"
        static let friday = "金"
        static let saturday = "土"
        static let sunday = "日"
        static let deletionNotPossible = "これ以上削除できません"
        static let additionNotPossible = "これ以上増やせません"
    }
    // MARK: - DefaultValue
    enum DefaultValue {
        static let schedule = ["", "", "", "", "", ""]
        static let scheduleCount = 6
        static let scheduleListMax = 10
        static let scheduleListMin = 1
    }
    // MARK: - Empty
    enum Empty {
        static let emptyText = ""
    }
}
