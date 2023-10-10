//
//  Monday.swift
//  ScheduleManagements
//
//  Created by 柿崎逸 on 2023/10/08.
//

import Foundation
import RealmSwift

class Monday: Object {
    @Persisted(primaryKey: true) var _id: ObjectId
    @Persisted var monDayList = List<String>()
    @Persisted var trainTime: Date
}

extension Monday: ObjectKeyIdentifiable {}

extension Monday {
    // MARK: - Methods
    func addMonDay(subjectArray: [String], trainTime: Date) {
        // TODO: - ここは、他のインスタンス生成方法があれば置き換える
        let monday = Monday()
        subjectArray.forEach {
            monday.monDayList.append($0)
        }
        monday.trainTime = trainTime
        RealmCRUD.realmAdd(weekModel: monday)
    }

    func updateMonDay(subjectArray: [String], date: Date) {
        // TODO: 以下の(firstObject: Monday)修正できるかも
        RealmCRUD.realmUpdate(weekModel: Self.self) { (firstObject: Monday) in
            for index in 0 ..< subjectArray.count {
                firstObject.monDayList[index] = subjectArray[index]
            }
        }
    }

    // Listの中身の数を返す
    func countMonDayList() -> Int {
        guard let localRealm = try? Realm() else { return 0 }
        guard let firstObjct = localRealm.objects(Self.self).first else { return 0 }
        return firstObjct.monDayList.count
    }

    func deleteAllMonDay() {
        RealmCRUD.realmDelete(weekModel: Self.self)
    }

    func readMonday() -> (List<String>, Date) {
        guard let lastObject = RealmCRUD.realmRead(weekModel: Self.self) else {
            let emptyList = List<String>()
            for _ in  0 ..< 6 {
                emptyList.append("")
            }
            return (emptyList, Date())
        }
        return (lastObject.monDayList, lastObject.trainTime)
    }
}
