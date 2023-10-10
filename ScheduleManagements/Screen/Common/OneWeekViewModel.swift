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
    // Mondayなどを一つのclassにまとめるといいかも
    func readSchedule<T: Object>(weekModel: T.Type) where T: Monday {
        guard let localRealm = try? Realm() else { return }
        if let objectFirstRecord = localRealm.objects(weekModel).last {
            subjectArray = objectFirstRecord.monDayList.map { $0 }
            trainTime = objectFirstRecord.trainTime
        } else {
            subjectArray = ["","","","","",""] // 初期値は、6限までの設定にするため
            trainTime = Date() // 初期は、現在時刻を入れておく
        }
    }
}
