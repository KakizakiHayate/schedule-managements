//
//  OneWeekViewModel.swift
//  ScheduleManagements
//
//  Created by 柿崎逸 on 2023/10/08.
//

import Foundation
import RealmSwift

@MainActor class OneWeekViewModel: ObservableObject {
    // MARK: - Property Wrappers
    @Published var showRevisionSheet = false
    @Published var trainTime = Date()
    @Published var chageObjectInt = 1
    @Published var subjectArray = [String]()

}

extension OneWeekViewModel {
    // MARK: - Methods
    func readSchedule() {
        let day = "月"
        switch day {
        case "月":
            let monday = Monday()
            guard let schedule = monday.readMonday() else {
                print("データベースから取得できませんでした")
                return
            }
            if (schedule.realm!.isEmpty) {
                print("true")
                schedule.monDayList.forEach {
                    subjectArray.append($0)
                }
                trainTime = schedule.date
            } else {
                subjectArray = ["","","","","",""]
                trainTime = Date()
            }
            // 最終的にsubjectArrayに入れる
        default:
            break
        }
    }
}
