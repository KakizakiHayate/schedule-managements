//
//  TrainTimeSettingView.swift
//  ScheduleManagements
//
//  Created by 柿崎逸 on 2023/11/21.
//

import SwiftUI
// TODO: 出発駅〜到着駅を設定
struct StationSettingView: View {
    @State private var dcxc = ""
    @State private var pickerIndex = -1
    @StateObject private var vm = StationSettingViewModel()

    // MARK: - Body
    var body: some View {
        ZStack {
            Color.customColorPurple
                .ignoresSafeArea()
            VStack {
                HStack {
                    Image(systemName: "magnifyingglass")
                        .padding(.leading)
                        .foregroundStyle(Color.white)
                        .bold()
                        .font(.title3)
                    TextField("\(dcxc)駅を入力", text: $dcxc)
                        .padding([.top, .trailing, .bottom])
                        .textFieldStyle(RoundedBorderTextFieldStyle())
                }
                HStack {
                    Spacer()
                    Picker(AppConst.Empty.emptyText, selection: $vm.japaneseRegionIndex) {
                        Text("地名を選択")
                        ForEach(AppConst.JapaneseRegion.all, id: \.self) {
                            Text($0.name).tag($0.id)
                        }
                    }.pickerStyle(.automatic)
                        .background(Color.white)
                        .clipShape(RoundedRectangle(cornerRadius: 10))
                        .tint(Color.black)
                        .onChangeInteractivelyAvailable(vm.japaneseRegionIndex) {
                            vm.switchingPrefecture($1)
                        }
                    Picker(AppConst.Empty.emptyText, selection: $vm.japanesePrefectureIndex) {
                        Text("都道府県を選択")
                        ForEach(AppConst.JapanesePrefecture.all, id: \.self) {
                            Text($0.name).tag($0.id)
                        }
                    }.pickerStyle(.automatic)
                        .background(Color.white)
                        .clipShape(RoundedRectangle(cornerRadius: 10))
                        .tint(Color.black)
//                        .onChangeInteractivelyAvailable(vm.japanesePrefectureIndex) {
//                            vm.switchingPrefecture(index: $1)
//                        }
                }.padding(.trailing)
                List {
                    ForEach(vm.stationNames) {
                        Text("\($0.station.name)")
                    }
                }
            }.task {
                await vm.fetchStationName(stationName: "きた")
            }
        }
    } // body

} // view

// MARK: - Preview
#Preview {
    StationSettingView()
}
