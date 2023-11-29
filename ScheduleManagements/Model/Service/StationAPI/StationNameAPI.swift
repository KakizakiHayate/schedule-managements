//
//  StationNameAPI.swift
//  ScheduleManagements
//
//  Created by 柿崎逸 on 2023/11/26.
//

import Foundation

struct StationNameAPI: Decodable {
    let resultSet: ResultSet

    enum CodingKeys: String, CodingKey {
        case resultSet = "ResultSet"
    }
}
