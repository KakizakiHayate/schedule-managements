//
//  OneWeekSelectView.swift
//  ScheduleManagements
//
//  Created by 柿崎逸 on 2023/10/08.
//

import SwiftUI

/// 曜日選択画面
struct OneWeekSelectView: View {

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
                                OneWeekView<Saturday>()
                            } label: {
                                Text("土")
                                    .font(.title)
                                    .foregroundColor(.white)
                                    .frame(width: 65, height: 65)
                                    .background(Color.customColorPurple)
                                    .cornerRadius(40)
                            }.padding(.bottom)

                            NavigationLink {
                                OneWeekView<Sunday>()
                            } label: {
                                Text("日")
                                    .font(.title)
                                    .foregroundColor(.white)
                                    .frame(width: 65, height: 65)
                                    .background(Color.customColorPurple)
                                    .cornerRadius(40)
                            }.padding(.top)
                        }.padding(.trailing)

                        VStack {
                            NavigationLink {
                                OneWeekView<Wednesday>()
                            } label: {
                                Text("水")
                                    .font(.title)
                                    .foregroundColor(.white)
                                    .frame(width: 65, height: 65)
                                    .background(Color.customColorPurple)
                                    .cornerRadius(40)
                            }.padding(.bottom)
                            NavigationLink {
                                OneWeekView<Thursday>()
                            } label: {
                                Text("木")
                                    .font(.title)
                                    .foregroundColor(.white)
                                    .frame(width: 65, height: 65)
                                    .background(Color.customColorPurple)
                                    .cornerRadius(40)
                            }
                            NavigationLink {
                                OneWeekView<Friday>()
                            } label: {
                                Text("金")
                                    .font(.title)
                                    .foregroundColor(.white)
                                    .frame(width: 65, height: 65)
                                    .background(Color.customColorPurple)
                                    .cornerRadius(40)
                            }.padding(.top)
                        }

                        VStack {
                            NavigationLink {
                                OneWeekView<Monday>()

                            } label: {
                                Text("月")
                                    .font(.title)
                                    .foregroundColor(.white)
                                    .frame(width: 65, height: 65)
                                    .background(Color.customColorPurple)
                                    .cornerRadius(40)
                            }.padding(.bottom)

                            NavigationLink {
                                OneWeekView<Tuesday>()
                            } label: {
                                Text("火")
                                    .font(.title)
                                    .foregroundColor(.white)
                                    .frame(width: 65, height: 65)
                                    .background(Color.customColorPurple)
                                    .cornerRadius(40)
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
