//
//  OneWeek.swift
//  ScheduleManagements
//
//  Created by 柿崎逸 on 2023/10/10.
//

import Foundation
import RealmSwift

/// MondayモデルからSundayモデルが共通で使うカラム名とメソッドのプロトコル
@MainActor
protocol WeekDay where Self: Object {
    // MARK: - Properties
    var _id: ObjectId { get }
    var scheduleList: List<String> { get set }
    var trainTime: Date? { get set }
}

extension WeekDay {
    // MARK: - Methods
    func addSchedule<T: WeekDay>(weekDayModel: T,
                                 subjects: [String],
                                 trainTime: Date?
    ) async {
        if let lastObject = await RealmCRUD.realmRead(weekModel: T.self) {
            // リセットボタンを押した時の処理
            if subjects.count == AppConst.DefaultValue.scheduleCount
                && subjects.allSatisfy({ $0 == AppConst.Empty.emptyText }) {
                let newObject = await newObjectAdd(weekDayModel: weekDayModel,
                                             subjects: subjects,
                                             trainTime: trainTime)
                await RealmCRUD.realmAdd(weekModel: newObject)
            }

            // realmに保存している配列の要素数と保存したい配列の要素数が同じなら更新する
            if subjects.count == weekDayModel.scheduleList.count {
                await RealmCRUD.realmUpdate(weekModel: lastObject,
                                      subjects: subjects,
                                      trainTime: trainTime)
            }

            // realmに保存している配列の要素数と保存したい配列の要素数が異なるなら追加する
            if subjects.count != weekDayModel.scheduleList.count {
                let newObject = await newObjectAdd(weekDayModel: weekDayModel,
                                             subjects: subjects,
                                             trainTime: trainTime)
                await RealmCRUD.realmAdd(weekModel: newObject)
            }
        } else {
            let newObject = await newObjectAdd(weekDayModel: weekDayModel,
                                         subjects: subjects,
                                         trainTime: trainTime)

            await RealmCRUD.realmAdd(weekModel: newObject)
        }
    }

    /// realmで追加するときに使う
    private func newObjectAdd<T: WeekDay>(weekDayModel: T,
                                          subjects: [String],
                                          trainTime: Date?
    ) async -> T {
        let newObject = T.init()
        subjects.forEach {
            newObject.scheduleList.append($0)
        }
        newObject.trainTime = trainTime

        return newObject
    }

    func readSchedule<T: WeekDay>(weekModel _: T) async -> (List<String>, Date?) {
        if let lastObject = await RealmCRUD.realmRead(weekModel: T.self) {
            return (lastObject.scheduleList, lastObject.trainTime)
        } else {
            let emptyList = List<String>()
            (0 ..< 6).forEach { _ in
                emptyList.append("")
            }
            return (emptyList, nil)
        }
    }

    // TODO: まだ使ってない
//    func deleteAllMonDay() {
//        RealmCRUD.realmDelete(weekModel: Self.self)
//    }
}
