//
//  OneWeekViewModel.swift
//  ScheduleManagements
//
//  Created by 柿崎逸 on 2023/10/08.
//

import Foundation
import RealmSwift

@MainActor
class OneWeekViewModel: ObservableObject {
    // MARK: - Property Wrappers
    @Published var showRevisionSheet = false
    @Published var trainTime = Date()
    @Published var chageObjectInt = 1
    @Published var subjectArray = [String]()

}
// [String],Date型が返ってくれば格納できる
extension OneWeekViewModel {
    // MARK: - Methods
    func readSchedule<T: Object>(weekModel: T.Type) {
        let monday = Monday()
        let (mondayList, trainTime) = monday.readMonday()
        subjectArray = mondayList.map { $0 }
        self.trainTime = trainTime
    }
}
