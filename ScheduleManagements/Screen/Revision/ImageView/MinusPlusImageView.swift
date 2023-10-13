//
//  MinusPlusButtonsView.swift
//  ScheduleManagements
//
//  Created by 柿崎逸 on 2023/10/14.
//

import SwiftUI

struct MinusPlusImageView: View {
    // MARK: - Property Wrappers
    @StateObject private var uiDeviceSizeManager = UIDeviceSizeManager.shared
    // MARK: - Properties
    var isMinusPlus: Bool

    // MARK: - Initialize
    init(isMinusPlus: Bool) {
        self.isMinusPlus = isMinusPlus
    }

    // MARK: - Body
    var body: some View {
        Image(systemName: isMinusPlus ? "plus" : "minus")
            .foregroundColor(.customColorPurple)
            .frame(width: uiDeviceSizeManager.isIpad() ? 50 : 44,
                   height: uiDeviceSizeManager.isIpad() ? 50 : 44)
            .font(.system(size: 20))
            .bold()
    } // body
} // view

// MARK: - Preview
#Preview {
    MinusPlusImageView(isMinusPlus: false)
}
