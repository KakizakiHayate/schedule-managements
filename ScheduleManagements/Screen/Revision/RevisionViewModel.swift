//
//  RevisionViewModel.swift
//  ScheduleManagements
//
//  Created by 柿崎逸 on 2023/10/10.
//

import Foundation

@MainActor
class RevisionViewModel<T: WeekDay>: ObservableObject {
    // MARK: - Property Wrappers
    @Published var subjects = [String]()
    @Published var trainTime: Date?
    @Published var isScheduleListAlert = false
    @Published var scheduleListUpperLimit = ""
    @Published var isTextFieldAlert = false
    @Published var isResetConfirmation = false
    // MARK: - Properties
    let textFieldLimit = 15
}

extension RevisionViewModel {
    // MARK: - Methods
    func readSchedule(weekDayModel: T) async {
        let (subjects, trainTime) = await weekDayModel.readSchedule(weekModel: weekDayModel)
        self.subjects = subjects.map { $0 }
        if let trainTime {
            self.trainTime = trainTime
        } else {
            self.trainTime = Date()
        }

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
