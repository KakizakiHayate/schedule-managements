//
//  Extension+View.swift
//  ScheduleManagements
//
//  Created by 柿崎逸 on 2023/11/26.
//

import Foundation
import SwiftUI

extension View {
    // MARK: - Methods
    @ViewBuilder
    func onChangeInteractivelyAvailable<T: Equatable>(_ index: T,
                                        action: @escaping (T?, T) async -> Void
    ) -> some View {
        if #available(iOS 17.0, *) {
            onChange(of: index) { oldValue, newValue in
                Task {
                    await action(oldValue, newValue)
                }
            }
        } else {
            onChange(of: index) { newValue in
                Task {
                    await action(nil, newValue)
                }
            }
        }
    }
}
