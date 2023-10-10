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

    func readMonday() -> Monday? {
        return RealmCRUD.realmRead(weekModel: Self.self) ?? nil
//        let obj = localRealm.objects(Monday.self)
//        //データベースに値が入っているなら保存されたデータをself.変数に代入、空なら初期値を代入
//        if obj.isEmpty {
//            self.subjectArray = ["","","","","",""]
//            self.date = Date()
//        } else {
//            //ListのデータをsubjectArrayに代入する。
//            //subjectArrayは、TextFieldのtext:の型がBinding<String>だから代入する必要がある。
//            if let schedule = mondayModel.first {
//                for subject in schedule.monDayList {
//                    subjectArray.append(subject)
//                }
//            }
//            //保存されたdateをself.dateに代入
//            let objFirst = localRealm.objects(Monday.self).first!
//            self.date = objFirst.date
//        }
    }
}
