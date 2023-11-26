//
//  Prefecture.swift
//  ScheduleManagements
//
//  Created by 柿崎逸 on 2023/11/26.
//

import Foundation

struct Prefecture: Codable {
    let name: String

    enum CodingKeys: String, CodingKey {
        case name = "Name"
    }
}
