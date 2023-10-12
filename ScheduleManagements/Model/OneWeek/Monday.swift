//
//  Monday.swift
//  ScheduleManagements
//
//  Created by 柿崎逸 on 2023/10/08.
//

import Foundation
import RealmSwift

class Monday: Object, WeekDay {
    @Persisted(primaryKey: true) private(set) var _id: ObjectId
    @Persisted var scheduleList = List<String>()
    @Persisted var trainTime = Date()
}

extension Monday: ObjectKeyIdentifiable {}

extension Monday {
    // MARK: - Methods
    // Listの中身の数を返す
    func countMonDayList() -> Int {
        guard let localRealm = try? Realm() else { return 0 }
        guard let firstObjct = localRealm.objects(Self.self).first else { return 0 }
        return firstObjct.scheduleList.count
    }

    // TODO: ここは共通できる気がする
    func deleteAllMonDay() {
        RealmCRUD.realmDelete(weekModel: Self.self)
    }
}
