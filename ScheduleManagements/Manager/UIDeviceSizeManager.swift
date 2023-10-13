//
//  UIDeviceSizeManager.swift
//  ScheduleManagements
//
//  Created by 柿崎逸 on 2023/10/13.
//

import Foundation
import SwiftUI

final class UIDeviceSizeManager: ObservableObject {
    // MARK: - Properties
    static let shared = UIDeviceSizeManager()

    // MARK: - Initialize
    private init() {}
}

extension UIDeviceSizeManager {
    // MARK: - Methods
    func isIpad() -> Bool {
        return UIDevice.current.userInterfaceIdiom == .pad
    }
}
