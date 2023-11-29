//
//  ResultSet.swift
//  ScheduleManagements
//
//  Created by 柿崎逸 on 2023/11/26.
//

import Foundation

struct ResultSet: Decodable {
    let apiVersion: String
    let max: String
    let offset: String
    let engineVersion: String
    let point: [Point]?

    enum CodingKeys: String, CodingKey {
        case apiVersion
        case max
        case offset
        case engineVersion
        case point = "Point"
    }
}
