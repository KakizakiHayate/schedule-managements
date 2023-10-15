//
//  MigrationManager.swift
//  ScheduleManagements
//
//  Created by 柿崎逸 on 2023/10/10.
//

import Foundation

/// RealmのマイグレーションManagerクラス
final class MigrationManager: ObservableObject {
    // MARK: - Property Wrappers
    @Published private(set) var version = UInt64(3)
    // MARK: - Properties
    static let shared = MigrationManager()

    // MARK: - Initialize
    private init() {}
}
