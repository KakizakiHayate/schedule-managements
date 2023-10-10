//
//  MigrationManager.swift
//  ScheduleManagements
//
//  Created by 柿崎逸 on 2023/10/10.
//

import Foundation

final class MigrationManager: ObservableObject {
    // MARK: - Property Wrappers
    @Published private(set) var version = UInt64(1)
    // MARK: - Properties
    static let shared = MigrationManager()
    private init() {}
}
