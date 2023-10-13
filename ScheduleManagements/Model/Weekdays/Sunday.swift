//
//  Sunday.swift
//  ScheduleManagements
//
//  Created by 柿崎逸 on 2023/10/12.
//

import Foundation
import RealmSwift

class Sunday: Object, WeekDay {
    // MARK: - Property Wrappers
    @Persisted(primaryKey: true) private(set) var _id: ObjectId
    @Persisted var scheduleList = List<String>()
    @Persisted var trainTime = Date()
}

extension Sunday: ObjectKeyIdentifiable {}
