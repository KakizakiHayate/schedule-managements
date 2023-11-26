//
//  StationSelectView.swift
//  ScheduleManagements
//
//  Created by 柿崎逸 on 2023/11/24.
//

import SwiftUI

struct StationSelectView<Destination>: View where Destination: View {
    // MARK: - Properties
    var title: LocalizedStringKey
    var station: LocalizedStringKey
    var destination: Destination

    // MARK: - Initialize
    init(title: LocalizedStringKey,
         station: LocalizedStringKey,
         @ViewBuilder destination: () -> Destination
    ) {
        self.title = title
        self.station = station
        self.destination = destination()
    }

    // MARK: - Body
    var body: some View {
        NavigationLink {
            destination
        } label: {
            HStack {
                Text(title)
                    .foregroundStyle(Color.customColorPurple)
                Text(station)
                    .foregroundStyle(Color.black)
                Spacer()
                Image(systemName: "chevron.right")
                    .foregroundStyle(Color.customColorPurple)
                    .bold()
            }.padding()
            .background(Color.white)
            .clipShape(RoundedRectangle(cornerRadius: 10))
            .shadow(color: .gray.opacity(0.2), radius: 3)
            .padding([.top, .leading, .trailing])
        }
    } // body
} // view

// MARK: - Preview
#Preview {
    StationSelectView(title: "出発", station: "駅を指定", destination: {
        EmptyView()
    })
}
