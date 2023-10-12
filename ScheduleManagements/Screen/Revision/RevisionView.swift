//
//  RevisionView.swift
//  ScheduleManagements
//
//  Created by 柿崎逸 on 2023/10/08.
//

import SwiftUI
import RealmSwift

/// 教科と電車時刻を修正画面
struct RevisionView<T: Object & WeekDay>: View {
    // MARK: - Property Wrappers
    @State private var showingAlertPlus = false
    @State private var showingAlertMinus = false
    @Binding var showRevisionSheet: Bool
    @Binding var weekDayModel: T
    @StateObject private var vm = RevisionViewModel<T>()

    // MARK: - Body
    var body: some View {
        ScrollView {
            VStack {
                Text("教科と電車時刻を修正").font(.title2).bold().padding()
                HStack {
                    Spacer()
                    Button {
                        // 以下2行は、メソッド化できる
                        vm.subjects = AppConst.DefaultValue.schedule
                        vm.trainTime = Date()
                    } label: {
                        Text("リセット").foregroundColor(Color.customColorPurple)
                            .padding(.trailing)
                    }
                }
                ForEach(0 ..< vm.subjects.count, id: \.self) { index in
                    HStack {
                        Text("\(index + 1)限目")
                            .font(.system(size: 15))
                            .foregroundColor(Color.customColorPurple)
                            .bold()
                            .padding(.bottom)
                            .padding(.leading)
                        // このtext: は、Binding<String>になっているから入力させるなら今の状態ならOK
                        TextField("未入力", text: $vm.subjects[index])
                            .textFieldStyle(RoundedBorderTextFieldStyle())
                            .padding(.bottom)
                            .padding(.trailing)
                    }
                }
                HStack {
                    Spacer()
                    // マイナスボタン
                    Button {
                        // 最低1まで来たら減らせない
                        if vm.subjects.count == 1 {
                            showingAlertMinus = true
                        } else {
                            vm.subjects.removeLast()
                        }
                    } label: {
                        Image(systemName: "minus")
                            .foregroundColor(Color.customColorPurple)
                            .bold()
                    }
                    .padding(.trailing).padding(.bottom)
                    .alert("お知らせ", isPresented: $showingAlertMinus) {
                        Button("OK") {}
                    } message: {
                        Text("これ以上削除できません")
                    }
                    // プラスボタン
                    Button {
                        // 最大10まで来たら増やせない
                        if vm.subjects.count == 10 {
                            showingAlertPlus = true
                        } else {
                            vm.subjects.append("")
                        }
                    } label: {
                        Image(systemName: "plus")
                            .foregroundColor(Color.customColorPurple)
                            .bold()
                    }
                    .padding(.trailing).padding(.bottom)
                    .alert("お知らせ", isPresented: $showingAlertPlus) {
                        Button("OK") {}
                    } message: {
                        Text("これ以上増やせません")
                    }
                }
                Spacer()
                DatePicker("電車の時間",
                           selection: $vm.trainTime,
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
