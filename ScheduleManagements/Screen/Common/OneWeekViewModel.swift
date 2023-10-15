//
//  OneWeekViewModel.swift
//  ScheduleManagements
//
//  Created by 柿崎逸 on 2023/10/08.
//

import Foundation
import RealmSwift

@MainActor
class OneWeekViewModel<T: WeekDay>: ObservableObject {
    // MARK: - Property Wrappers
    @Published var showRevisionSheet = false
    @Published var trainTime: Date?
    @Published var subjects = [String]()
    // MARK: - Properties
    var weekDayModel = T.init()
}

extension OneWeekViewModel {
    // MARK: - Methods
    func readSchedule(weekDayModel: T) {
        let (subjects, trainTime) = weekDayModel.readSchedule(weekModel: weekDayModel)
        self.subjects = subjects.map { $0 }
        self.trainTime = trainTime
    }
}
