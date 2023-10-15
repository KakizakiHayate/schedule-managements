//
//  RevisionView.swift
//  ScheduleManagements
//
//  Created by 柿崎逸 on 2023/10/08.
//

import SwiftUI
import RealmSwift
import Combine

/// 教科と電車時刻を修正画面
struct RevisionView<T: WeekDay>: View {
    // MARK: - Property Wrappers
    @Binding var showRevisionSheet: Bool
    @Binding var weekDayModel: T
    @StateObject private var vm = RevisionViewModel<T>()
    @StateObject private var uiDeviceSizeManager = UIDeviceSizeManager.shared

    // MARK: - Body
    var body: some View {
        ScrollView {
            VStack {
                Text("教科と電車時刻を修正").font(.title2).bold().padding()
                HStack {
                    Spacer()
                    Button {
                        vm.isResetConfirmation.toggle()
                    } label: {
                        Text("リセット")
                            .foregroundColor(.customColorPurple)
                            .padding()
                            .bold()
                    }.alert("確認", isPresented: $vm.isResetConfirmation) {
                        Button("キャンセル") {}
                        Button {
                            vm.subjects = AppConst.DefaultValue.schedule
                            vm.trainTime = nil
                        } label: {
                            Text("OK")
                        }
                    } message: {
                        Text("本当にリセットしますか？")
                    }
                }
                ForEach(0 ..< vm.subjects.count, id: \.self) { index in
                    HStack {
                        Text("\(index + 1)限目")
                            .font(.system(size: 15))
                            .foregroundColor(.customColorPurple)
                            .bold()
                            .padding(.bottom)
                            .padding(.leading)
                        TextField("未入力", text: $vm.subjects[index])
                            .textFieldStyle(RoundedBorderTextFieldStyle())
                            .padding(.bottom)
                            .padding(.trailing)
                            .onReceive(Just(vm.subjects[index])) { _ in
                                if vm.textFieldLimit <
                                    vm.subjects[index].count {
                                    vm.subjects[index] = String(vm.subjects[index].prefix(vm.textFieldLimit))
                                    vm.isTextFieldAlert.toggle()
                                }
                            }
                            .alert("注意", isPresented: $vm.isTextFieldAlert) {
                                Button("OK") {}
                            } message: {
                                Text("これ以上入力できません")
                            }
                    }
                }
                HStack {
                    Spacer()
                    // マイナスボタン
                    Button {
                        vm.scheduleListMin()
                    } label: {
                        MinusPlusImageView(isMinusPlus: false)
                    }.padding(.trailing).padding(.bottom)
                    // プラスボタン
                    Button {
                        vm.scheduleListMax()
                    } label: {
                        MinusPlusImageView(isMinusPlus: true)
                    }.padding(.trailing).padding(.bottom)

                }.alert("お知らせ", isPresented: $vm.isScheduleListAlert) {
                    Button("OK") {}
                } message: {
                    Text("\(vm.scheduleListUpperLimit)")
                }
                Spacer()
                DatePicker("電車の時間",
                           selection: Binding(
                               get: { return vm.trainTime ?? Date() },
                               set: { vm.trainTime = $0 }
                           ),
                           displayedComponents: .hourAndMinute)
                .padding()
                Button {
                    // 設定完了したらsheetを閉じる
                    showRevisionSheet = false
                    weekDayModel.addSchedule(weekDayModel: &weekDayModel,
                                             subjects: vm.subjects,
                                             trainTime: vm.trainTime)
                } label: {
                    Text("変更完了")
                        .padding()
                        .background(Color.customColorPurple)
                        .foregroundColor(.white)
                        .cornerRadius(30)
                        .padding()
                }
            }.onAppear { vm.readSchedule(weekDayModel: weekDayModel) }
        }
    } // body
} // view

// MARK: - Preview
#Preview {
    RevisionView(showRevisionSheet: .constant(false),
                 weekDayModel: .constant( Monday() ))
}
