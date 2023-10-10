//
//  RevisionView.swift
//  ScheduleManagements
//
//  Created by 柿崎逸 on 2023/10/08.
//

import SwiftUI

struct RevisionView: View {

    @State private var showingAlertPlus = false
    @State private var showingAlertMinus = false
    @Binding var subjectArray: [String]
    @Binding var showRevisionSheet: Bool
    @Binding var trainTime: Date
    @Binding var changeObjectInt: Int

    var body: some View {
        ScrollView {
            VStack {
                    Text("修正画面").font(.title2).bold().padding()

                HStack {

                    Spacer()

                    Button(action: {
                        // changeObject関数から返ってきた値でdeleteAllScheduleGroup()する
                        changeObjectReset(changeObjectInt: changeObjectInt)

                        subjectArray = ["","","","","",""]
                        trainTime = Date()
                    }) {
                        Text("リセット").foregroundColor(Color.customColorPurple).padding(.trailing)
                    }
                }


                ForEach(0 ..< subjectArray.count, id: \.self) { item in
                    HStack {
                        Text("\(item + 1)限目")
                            .font(.system(size: 15))
                            .foregroundColor(Color.customColorPurple)
                            .bold()
                            .padding(.bottom)
                            .padding(.leading)

                        //このtext: は、Binding<String>になっているから入力させるなら今の状態ならOK
                        TextField("未入力", text: $subjectArray[item])
                            .textFieldStyle(RoundedBorderTextFieldStyle())
                            .padding(.bottom)
                            .padding(.trailing)
                    }
                }

                HStack {

                    Spacer()
                    //マイナスボタン
                    Button(action: {
                        //最低1まで来たら減らせない
                        if subjectArray.count == 1 {
                            showingAlertMinus = true
                        } else {
                            subjectArray.removeLast()
                        }


                    }) {
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
                    //プラスボタン
                    Button(action: {
                        //最大10まで来たら増やせない
                        if subjectArray.count == 10 {
                            showingAlertPlus = true
                        } else {
                            subjectArray.append("")
                        }


                    }) {
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

                DatePicker("電車の時間", selection: $trainTime, displayedComponents: .hourAndMinute)
                    .padding()

                Button(action: {
                    //設定完了したらsheetを閉じる
                    showRevisionSheet = false
                    Monday().addMonDay(subjectArray: subjectArray, trainTime: trainTime)
                    changeObjectComplete(changeObjectInt: changeObjectInt)

                }) {
                    Text("変更完了")
                        .padding()
                        .background(Color.customColorPurple)
                        .foregroundColor(.white)
                        .cornerRadius(30)
                }

            }
        }
    }
    //リセットボタン
    //条件分岐させた後にデータベースをallDeleteする。
    func changeObjectReset(changeObjectInt: Int) {
        switch changeObjectInt {
        case 1:
            let monday = Monday()
            monday.deleteAllMonDay()
        default:
            return
        }
    }
    //設定完了ボタン
    func changeObjectComplete(changeObjectInt: Int) {

    }
}

#Preview {
    RevisionView(subjectArray: .constant([]),
                 showRevisionSheet: .constant(false),
                 trainTime: .constant(Date()),
                 changeObjectInt: .constant(0)
    )
}
