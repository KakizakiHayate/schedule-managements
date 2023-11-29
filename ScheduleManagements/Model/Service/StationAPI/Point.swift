//
//  Point.swift
//  ScheduleManagements
//
//  Created by 柿崎逸 on 2023/11/26.
//

import Foundation

struct Point: Decodable, Identifiable {
    let id = UUID()
    let station: Station
    let prefecture: Prefecture

    enum CodingKeys: String, CodingKey {
        case station = "Station"
        case prefecture = "Prefecture"
    }
}
