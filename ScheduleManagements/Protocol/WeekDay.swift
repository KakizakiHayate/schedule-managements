//
//  OneWeek.swift
//  ScheduleManagements
//
//  Created by 柿崎逸 on 2023/10/10.
//

import Foundation
import RealmSwift

protocol WeekDay where Self: Object {
    // MARK: - Properties
    var _id: ObjectId { get }
    var scheduleList: List<String> { get set }
    var trainTime: Date { get set }
}

extension WeekDay {
    // MARK: - Methods
    func addSchedule<T: WeekDay>(weekDayModel: inout T,
                                 subjects: [String],
                                 trainTime: Date
    ) {
        if var lastObject = RealmCRUD.realmRead(weekModel: T.self) {
            // Realmに更新するときの処理
            if subjects.count == AppConst.DefaultValue.scheduleCount
                && subjects.allSatisfy({ $0 == AppConst.Empty.emptyText }) {
                let newObject = newObjectAdd(weekDayModel: weekDayModel,
                                             subjects: subjects,
                                             trainTime: trainTime)
                RealmCRUD.realmAdd(weekModel: newObject)
            }

            if subjects.count == weekDayModel.scheduleList.count {
                RealmCRUD.realmUpdate(weekModel: &lastObject,
                                      subjects: subjects,
                                      trainTime: trainTime)
            }

            if subjects.count != weekDayModel.scheduleList.count {
                let newObject = newObjectAdd(weekDayModel: weekDayModel,
                                             subjects: subjects,
                                             trainTime: trainTime)
                RealmCRUD.realmAdd(weekModel: newObject)
            }
        } else {
            // realmに追加するときの処理
            let newObject = newObjectAdd(weekDayModel: weekDayModel,
                                         subjects: subjects,
                                         trainTime: trainTime)
            RealmCRUD.realmAdd(weekModel: newObject)
        }
    }

    private func newObjectAdd<T: WeekDay>(weekDayModel: T,
                                          subjects: [String],
                                          trainTime: Date
    ) -> T {
        let newObject = T.init()
        subjects.forEach {
            newObject.scheduleList.append($0)
        }
        newObject.trainTime = trainTime

        return newObject
    }

    func readSchedule<T: WeekDay>(weekModel _: T) -> (List<String>, Date) {
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
