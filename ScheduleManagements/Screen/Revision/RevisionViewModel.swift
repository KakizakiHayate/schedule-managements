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
    @Published var isScheduleListAlert = false
    @Published var scheduleListUpperLimit = ""
}

extension RevisionViewModel {
    // MARK: - Methods
    func readSchedule(weekDayModel: T) {
        let (subjects, trainTime) = weekDayModel.readSchedule(weekModel: weekDayModel)
        self.subjects = subjects.map { $0 }
        self.trainTime = trainTime
    }

    func scheduleListMin() {
        if subjects.count == AppConst.DefaultValue.scheduleListMin {
            scheduleListUpperLimit = AppConst.Text.deletionNotPossible
            isScheduleListAlert.toggle()
        } else {
            subjects.removeLast()
        }
    }

    func scheduleListMax() {
        if subjects.count == AppConst.DefaultValue.scheduleListMax {
            scheduleListUpperLimit = AppConst.Text.additionNotPossible
            isScheduleListAlert.toggle()
        } else {
            subjects.append(AppConst.Empty.emptyText)
        }
    }
}
