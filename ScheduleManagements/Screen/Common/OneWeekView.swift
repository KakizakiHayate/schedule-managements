//
//  OneWeekView.swift
//  ScheduleManagements
//
//  Created by 柿崎逸 on 2023/10/08.
//

import SwiftUI
import RealmSwift

/// 共通で使う教科と電車の時刻一覧画面
struct OneWeekView<T: WeekDay>: View {
    // MARK: - Property Wrappers
    @Binding var weekday: String
    @ObservedObject private var vm = OneWeekViewModel<T>()
    @StateObject private var dateManager = DateManager.shared

    // MARK: - Initialize
    init(weekday: Binding<String>) {
        self._weekday = weekday
        vm.weekDayModel = T.init()
    }

    // MARK: - Body
    var body: some View {
        VStack {
            NavigationStack {
                ZStack(alignment: .bottomTrailing) {
                    List {
                        Section {
                            ForEach(0 ..< vm.subjects.count, id: \.self) { subject in
                                VStack {
                                    // +1すると\(subject + 1)が1始まりになる。
                                    HStack {
                                        Text("\(subject + 1)： ")
                                            .foregroundColor(.customColorPurple).bold()
                                        Text("\(vm.subjects[subject])")
                                    }
                                }
                            }
                        } header: {
                            Text("時間割")
                        }
                        Section {
                            HStack {
                                Image(systemName: "train.side.front.car")
                                    .foregroundColor(.customColorPurple)
                                    .font(.system(size: 30.0))
                                // TODO: ここの判定は修正が必要
                                if vm.trainTime == nil {
                                    Text("電車の時刻が未設定です")
                                } else {
                                    Text("\(dateManager.sharedDate().string(from: vm.trainTime ?? Date()))の電車です")
                                }
                            }
                        } header: {
                            Text("電車の時刻")
                        }
                    }.navigationTitle("\(weekday)曜日")
                    Button {
                        vm.showRevisionSheet.toggle()
                    } label: {
                        Image(systemName: "pencil")
                            .foregroundColor(.white)
                            .font(.system(size: 40))
                    }
                    .frame(width: 70, height: 70)
                    .background(Color.customColorPurple)
                    .cornerRadius(40.0)
                    .padding(.bottom)
                    .padding(.trailing)
                    .sheet(isPresented: $vm.showRevisionSheet) {
                        // subjectArrayは、TextFieldのtext:の型がBinding<String>だから渡す必要がある
                        RevisionView<T>(showRevisionSheet: $vm.showRevisionSheet,
                                        weekDayModel: $vm.weekDayModel)
                        .onDisappear { vm.readSchedule(weekDayModel: vm.weekDayModel) }
                    }
                }
            }
        }.onAppear { vm.readSchedule(weekDayModel: vm.weekDayModel )
    }
    } // body
} // view

// MARK: - Preview
#Preview {
    OneWeekView<Monday>(weekday: .constant(""))
}
