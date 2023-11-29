//
//  APIError.swift
//  ScheduleManagements
//
//  Created by 柿崎逸 on 2023/11/26.
//

import Foundation

enum APIError: Error {
    case invalidUrl
    case invalidResponse
    case serverError(statusCode: Int)
    case decodingError
    case unknownError
}
