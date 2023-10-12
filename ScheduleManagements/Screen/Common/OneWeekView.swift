//
//  OneWeekView.swift
//  ScheduleManagements
//
//  Created by 柿崎逸 on 2023/10/08.
//

import SwiftUI
import RealmSwift

struct OneWeekView<T: Object & WeekDay>: View {
    // MARK: - Property Wrappers
    @ObservedObject private var vm = OneWeekViewModel<T>()
    @StateObject private var dateManager = DateManager.shared

    // MARK: - Initialize
    init() {
        vm.weekDayModel = T.init()
    }

    // MARK: - Body
    var body: some View {
        VStack {
            NavigationStack {
                ZStack(alignment: .bottomTrailing) {
                    List {
                        Section {
                            ForEach(0 ..< vm.subjectArray.count, id: \.self) { subject in
                                VStack {
                                    // +1すると\(subject + 1)が1始まりになる。
                                    HStack {
                                        Text("\(subject + 1)： ")
                                            .foregroundColor(Color.customColorPurple).bold()
                                        Text("\(vm.subjectArray[subject])")
                                    }
                                }
                            }
                        } header: {
                            Text("時間割")
                        }
                        Section {
                            HStack {
                                Image(systemName: "train.side.front.car")
                                    .foregroundColor(Color.customColorPurple)
                                    .font(.system(size: 30.0))
                                // TODO: ここの判定は修正が必要
                                if vm.trainTime == Date() {
                                    Text("電車の時刻が未設定です")
                                } else {
                                    Text("\(dateManager.sharedDate().string(from: vm.trainTime))の電車です")
                                }
                            }
                        } header: {
                            Text("電車の時刻")
                        }
                    }.navigationTitle("月曜日")
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
                        RevisionView<T>(subjectArray: $vm.subjectArray,
                                        showRevisionSheet: $vm.showRevisionSheet,
                                        trainTime: $vm.trainTime,
                                        changeObjectInt: $vm.chageObjectInt,
                                        weekDayModel: $vm.weekDayModel)
                    }
                }
            }
        }
        .onAppear {
            vm.readSchedule(weekDayModel: vm.weekDayModel)
        }
    } // body
} // view

#Preview {
    OneWeekView<Monday>()
}
