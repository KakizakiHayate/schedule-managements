//
//  StationSettingViewModel.swift
//  ScheduleManagements
//
//  Created by 柿崎逸 on 2023/11/26.
//

import Foundation

class StationSettingViewModel: ObservableObject {
    // MARK: - Property Wrappers
    @Published private(set) var stationNames = [Point]()
    @Published var japanesePrefectureIndex = -1
    @Published var japaneseRegionIndex = -1
}

extension StationSettingViewModel {
    // MARK: - Methods
    @MainActor
    func fetchStationName(stationName: String) async {
        guard var baseURL = URLComponents(string: "https://api.ekispert.jp/v1/json/station") else { return }
        baseURL.queryItems = [
            URLQueryItem.init(name: "key", value: "LE_DbXR7uzE6PnNz"),
            URLQueryItem.init(name: "name", value: stationName)
        ]
        guard let apiURL = baseURL.url else { return }

        do {
            let (data, response) = try await URLSession.shared.data(from: apiURL)
            guard let response = response as? HTTPURLResponse else { return }
            guard (200 ... 299).contains(response.statusCode) else {
                Logger.standard.error("\(APIError.serverError(statusCode: response.statusCode))")
                return
            }
            guard let decodeReponse = try? JSONDecoder().decode(StationNameAPI.self, from: data) else {
                Logger.standard.error("\(APIError.decodingError)")
                return
            }
            stationNames = decodeReponse.resultSet.point
        } catch {
            Logger.standard.error("\(APIError.invalidResponse)")
        }
    }

    func switchingPrefecture(_ index: Int) {

    }
}
