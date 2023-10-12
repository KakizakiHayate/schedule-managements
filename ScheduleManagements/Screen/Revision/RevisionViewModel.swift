//
//  RevisionViewModel.swift
//  ScheduleManagements
//
//  Created by 柿崎逸 on 2023/10/10.
//

import Foundation

class RevisionViewModel<T: WeekDay>: ObservableObject {
    // MARK: - Property Wrappers
    @Published var subjects = [String]()
    @Published var trainTime = Date()
}

extension RevisionViewModel {
    // MARK: - Methods
    func readSchedule(weekDayModel: T) {
        let (subjects, trainTime) = weekDayModel.readSchedule(weekModel: weekDayModel)
        self.subjects = subjects.map { $0 }
        self.trainTime = trainTime
    }
}
