//
//  Monday.swift
//  ScheduleManagements
//
//  Created by 柿崎逸 on 2023/10/08.
//

import Foundation
import RealmSwift

class Monday: Object, WeekDay {
    // MARK: - Property Wrappers
    @Persisted(primaryKey: true) private(set) var _id: ObjectId
    @Persisted var scheduleList = List<String>()
    @Persisted var trainTime: Date?
}

extension Monday: ObjectKeyIdentifiable {}
