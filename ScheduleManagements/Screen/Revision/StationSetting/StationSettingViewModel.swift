//
//  StationSettingViewModel.swift
//  ScheduleManagements
//
//  Created by 柿崎逸 on 2023/11/26.
//

import Foundation
import Combine

class StationSettingViewModel: ObservableObject {
    // MARK: - Property Wrappers
    @Published private(set) var stationNames = [Point]()
    @Published var isProgress = true
    @Published var japanesePrefectureIndex = 1
    @Published var japaneseRegionIndex = -1
    @Published var japanesePrefectures = [AppConst.JapanesePrefecture]()
    @Published var stationNameInput = ""
    // MARK: - Properties
    private var searchCancellable: AnyCancellable?

    init() {
        self.setupSearchCancellable()
    }
}

extension StationSettingViewModel {
    // MARK: - Methods
    @MainActor
    func fetchStationName(_ stationName: String, _ prefecture: Int?) async {
        self.isProgress = true
        guard var baseURL = URLComponents(string: "https://api.ekispert.jp/v1/json/station") else { return }
        baseURL.queryItems = [
            URLQueryItem.init(name: "key", value: "LE_DbXR7uzE6PnNz"),
            URLQueryItem.init(name: "name", value: stationName)
        ]
        if let prefecture {
            baseURL.queryItems?.append(URLQueryItem.init(name: "prefectureCode", value: "\(prefecture)"))
        }
        guard let apiURL = baseURL.url else {
            print("urlキャスト失敗")
            return
        }
        print(apiURL)

        do {
            let (data, response) = try await URLSession.shared.data(from: apiURL)
            guard let response = response as? HTTPURLResponse else {
                print("キャスト失敗")
                return
            }
            guard (200 ... 299).contains(response.statusCode) else {
                Logger.standard.error("\(APIError.serverError(statusCode: response.statusCode))")
                return
            }
            let decodeReponse = try JSONDecoder().decode(StationNameAPI.self, from: data)
            if let response = decodeReponse.resultSet.point {
                self.stationNames = response
                self.isProgress = false
            } else {
                Logger.standard.error("response nil!!!!")
            }
        } catch {
            Logger.standard.error("\(error)")
        }
    }

    @MainActor
    func switchingPrefecture(_ index: Int) async {
        if let region = AppConst.JapaneseRegion.all.first(where: { $0.id == index }) {
            self.japanesePrefectures = region.prefectures
        } else {
            Logger.standard.error("地方が見つかりませんでした")
        }
    }

    private func urlSession(_ url: URL,
                            completion: @escaping (Result<[Point?], Error>) -> Void
    ) async {
        do {
            let (data, response) = try await URLSession.shared.data(from: url)
            guard let response = response as? HTTPURLResponse else {
                print("キャスト失敗")
                return
            }
            guard (200 ... 299).contains(response.statusCode) else {
                Logger.standard.error("\(APIError.serverError(statusCode: response.statusCode))")
                return
            }
            let decodeReponse = try JSONDecoder().decode(StationNameAPI.self,from: data)
        } catch {
            Logger.standard.error("\(error)")
        }
    }

    private func setupSearchCancellable() {
        self.searchCancellable = self.$stationNameInput
            .removeDuplicates()
            .debounce(for: 0.5, scheduler: RunLoop.main)
            .sink(receiveValue: { input in
                if input.isEmpty {
                    self.isProgress.toggle()
                } else {
                    Task {
                        await self.fetchStationName(input, nil)
                    }
                }
            })
    }
}
