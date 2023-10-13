//
//  ScheduleManagementsApp.swift
//  ScheduleManagements
//
//  Created by 柿崎逸 on 2023/10/05.
//

import SwiftUI
import RealmSwift

@main
struct ScheduleManagementsApp: SwiftUI.App {
    // MARK: - Property Wrappers
    @ObservedObject private var migrationManager = MigrationManager.shared

    // MARK: - initialize
    init() {
        let config = Realm.Configuration(schemaVersion: migrationManager.version)
        Realm.Configuration.defaultConfiguration = config
    }

    // MARK: - Body
    var body: some Scene {
        WindowGroup {
            OneWeekSelectView()
        }
    } // body
} // App
