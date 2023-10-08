//
//  dateFormatterManager.swift
//  ScheduleManagements
//
//  Created by 柿崎逸 on 2023/10/08.
//

import Foundation

final class DateManager: ObservableObject {
    // MARK: - Properties
    static let shared = DateManager()
    private let dateFormatter: DateFormatter
    // MARK: - Initialize
    private init() {
        dateFormatter = DateFormatter()
        dateFormatter.dateStyle = .none
        dateFormatter.timeStyle = .short
        dateFormatter.locale = Locale(identifier: "ja_JP")
    }
}

extension DateManager {
    // MARK: - Methods
    func sharedDate() -> DateFormatter {
        return dateFormatter
    }
}
