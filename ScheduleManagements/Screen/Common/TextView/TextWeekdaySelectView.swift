//
//  WeekdaySelectButton.swift
//  ScheduleManagements
//
//  Created by 柿崎逸 on 2023/10/12.
//

import SwiftUI

/// 曜日選択時に使う共通TextView
struct TextWeekdaySelectView: View {
    // MARK: - Property Wrappers
    private var weekday: String

    // MARK: - Initialize
    init(weekday: String) {
        self.weekday = weekday
    }

    // MARK: - Body
    var body: some View {
        Text("\(weekday)")
            .font(.title)
            .foregroundColor(.white)
            .frame(width: 65, height: 65)
            .background(Color.customColorPurple)
            .cornerRadius(40)
    } // body
} // view

// MARK: - Preview
#Preview {
    TextWeekdaySelectView(weekday: "水")
}
