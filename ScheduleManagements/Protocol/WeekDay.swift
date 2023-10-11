//
//  OneWeek.swift
//  ScheduleManagements
//
//  Created by 柿崎逸 on 2023/10/10.
//

import Foundation
import RealmSwift

protocol WeekDay {
    // MARK: - Properties
    var _id: ObjectId { get }
    var scheduleList: List<String> { get set }
    var trainTime: Date { get set }
}

extension WeekDay {
    // MARK: - Methods
    func addSchedule(subjectArray: [String], trainTime: Date) {
        // TODO: - ここは、他のインスタンス生成方法があれば置き換える
        let monday = Monday()
        subjectArray.forEach {
            monday.scheduleList.append($0)
        }
        monday.trainTime = trainTime
        RealmCRUD.realmAdd(weekModel: monday)
    }

    func readSchedule<T: Object & WeekDay>(weekModel _: T) -> (List<String>, Date) {
        if let lastObject = RealmCRUD.realmRead(weekModel: T.self) {
            return (lastObject.scheduleList, lastObject.trainTime)
        } else {
            let emptyList = List<String>()
            (0 ..< 6).forEach { _ in
                emptyList.append("")
            }
            return (emptyList, Date())
        }
    }
}
