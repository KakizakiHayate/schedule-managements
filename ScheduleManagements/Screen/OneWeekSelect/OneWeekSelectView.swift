//
//  OneWeekSelectView.swift
//  ScheduleManagements
//
//  Created by 柿崎逸 on 2023/10/08.
//

import SwiftUI

struct OneWeekSelectView: View {
    var body: some View {
        NavigationStack {
            ZStack {
                LinearGradient(gradient: Gradient(colors: [Color.customColorPurple, .white]),
                               startPoint: .top,
                               endPoint: .bottom)
                .ignoresSafeArea()
                VStack {
                    HStack {
                        
                        VStack {
                            //                            NavigationLink {
                            //                                SaturdayView(saturDayModel: SaturDayModel(), migration: Migration())
                            //
                            //                            } label: {
                            //                                Text("土")
                            //                                    .font(.title)
                            //                                    .foregroundColor(.white)
                            //                                    .frame(width: 65, height: 65)
                            //                                    .background(Color.customColorPurple)
                            //                                    .cornerRadius(40)
                            //                            }.padding(.bottom)
                            
                            //                            NavigationLink {
                            //                                SundayView(sunDayModel: SunDayModel(), migration: Migration())
                            //
                            //                            } label: {
                            //                                Text("日")
                            //                                    .font(.title)
                            //                                    .foregroundColor(.white)
                            //                                    .frame(width: 65, height: 65)
                            //                                    .background(Color.customColorPurple)
                            //                                    .cornerRadius(40)
                            //                            }.padding(.top)
                            //                        }.padding(.trailing)
                            
                            VStack {
                                //                            NavigationLink {
                                //                                WednesdayView(wednesDayModel: WednesDayModel(), migration: Migration())
                                //
                                //                            } label: {
                                //                                Text("水")
                                //                                    .font(.title)
                                //                                    .foregroundColor(.white)
                                //                                    .frame(width: 65, height: 65)
                                //                                    .background(Color.customColorPurple)
                                //                                    .cornerRadius(40)
                                //                            }.padding(.bottom)
                                
                                //                            NavigationLink {
                                //                                ThursdayView(thursDayModel: ThursDayModel(), migration: Migration())
                                //
                                //                            } label: {
                                //                                Text("木")
                                //                                    .font(.title)
                                //                                    .foregroundColor(.white)
                                //                                    .frame(width: 65, height: 65)
                                //                                    .background(Color.customColorPurple)
                                //                                    .cornerRadius(40)
                                //                            }
                                
                                //                            NavigationLink {
                                //                                FridayView(friDayModel: FriDayModel(), migration: Migration())
                                //
                                //                            } label: {
                                //                                Text("金")
                                //                                    .font(.title)
                                //                                    .foregroundColor(.white)
                                //                                    .frame(width: 65, height: 65)
                                //                                    .background(Color.customColorPurple)
                                //                                    .cornerRadius(40)
                                //                            }.padding(.top)
                                //                        }
                                
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
                                    
                                    //                            NavigationLink {
                                    //                                TuesdayView(tuesDayModel: TuesDayModel(), migration: Migration())
                                    //
                                    //                            } label: {
                                    //                                Text("火")
                                    //                                    .font(.title)
                                    //                                    .foregroundColor(.white)
                                    //                                    .frame(width: 65, height: 65)
                                    //                                    .background(Color.customColorPurple)
                                    //                                    .cornerRadius(40)
                                    //                            }.padding(.top)
                                    //                        }.padding(.leading)
                                    //
                                    //                    }
                                }
                            }
                        }
                    }
                }
            }
        }
    }
}

#Preview {
    OneWeekSelectView()
}
