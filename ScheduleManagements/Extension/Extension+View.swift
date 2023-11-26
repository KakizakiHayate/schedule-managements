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
    func onChangeInteractivelyAvailable(_ index: Int,
                                        action: @escaping (Int?, Int) -> Void
    ) -> some View {
        if #available(iOS 17.0, *) {
            onChange(of: index) {
                action($0, $1)
            }
        } else {
            onChange(of: index) {action(nil, $0)}
        }
    }
}
