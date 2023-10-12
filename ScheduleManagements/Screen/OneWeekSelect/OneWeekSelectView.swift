//
//  OneWeekSelectView.swift
//  ScheduleManagements
//
//  Created by 柿崎逸 on 2023/10/08.
//

import SwiftUI

/// 曜日選択画面
struct OneWeekSelectView: View {
    // MARK: - Property Wrappers
    @State private var weekday = ""
    // MARK: - Properties
    private let monday    = AppConst.Text.monday
    private let tuesday   = AppConst.Text.tuesday
    private let wednesday = AppConst.Text.wednesday
    private let thursday  = AppConst.Text.thursday
    private let friday    = AppConst.Text.friday
    private let saturday  = AppConst.Text.saturday
    private let sunday    = AppConst.Text.sunday

    // MARK: - Body
    var body: some View {
        NavigationStack {
            ZStack {
                LinearGradient(gradient: Gradient(colors: [Color.customColorPurple,
                                                           .white]),
                               startPoint: .top,
                               endPoint: .bottom)
                .ignoresSafeArea()
                VStack {
                    HStack {
                        VStack {
                            NavigationLink {
                                OneWeekView<Saturday>(weekday: $weekday)
                                    .onAppear { weekday = saturday }
                            } label: {
                                TextWeekdaySelectView(weekday: saturday)
                            }.padding(.bottom)

                            NavigationLink {
                                OneWeekView<Sunday>(weekday: $weekday)
                                    .onAppear { weekday = sunday }
                            } label: {
                                TextWeekdaySelectView(weekday: sunday)
                            }.padding(.top)
                        }.padding(.trailing)

                        VStack {
                            NavigationLink {
                                OneWeekView<Wednesday>(weekday: $weekday)
                                    .onAppear { weekday = wednesday }
                            } label: {
                                TextWeekdaySelectView(weekday: wednesday)
                            }.padding(.bottom)

                            NavigationLink {
                                OneWeekView<Thursday>(weekday: $weekday)
                                    .onAppear { weekday = thursday }
                            } label: {
                                TextWeekdaySelectView(weekday: thursday)
                            }

                            NavigationLink {
                                OneWeekView<Friday>(weekday: $weekday)
                                    .onAppear { weekday = friday }
                            } label: {
                                TextWeekdaySelectView(weekday: friday)
                            }.padding(.top)
                        }

                        VStack {
                            NavigationLink {
                                OneWeekView<Monday>(weekday: $weekday)
                                    .onAppear { weekday = monday }
                            } label: {
                                TextWeekdaySelectView(weekday: monday)
                            }.padding(.bottom)

                            NavigationLink {
                                OneWeekView<Tuesday>(weekday: $weekday)
                                    .onAppear { weekday = tuesday }
                            } label: {
                                TextWeekdaySelectView(weekday: tuesday)
                            }.padding(.top)
                        }.padding(.leading)
                    }
                }
            }
        }
    } // body
} // view

// MARK: - Preview
#Preview {
    OneWeekSelectView()
}
