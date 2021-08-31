//
//  WeatherAPIService+get.swift
//  NTC-Weather-Forecast-COVID-19
//
//  Created by trần nam on 8/31/21.
//

import Foundation

extension WeatherAPIService {
    func getDetailWeather(lat: Double, long: Double, completion: @escaping (Result<DetailWeather, Error>) -> Void) {
        WeatherAPIService.shared.pullJSONData(url: URL(string: WeatherNetwork.shared.getDetailWeather(lat: lat, long: long))) { (result) in
            switch result {
            case .success(let JSONData):
                let detailWeatherData = try? JSONDecoder().decode(DetailWeather.self, from: JSONData)
                if let detailWeatherData = detailWeatherData {
                    completion(.success(detailWeatherData))
                }
            case .failure(let error):
                completion(.failure(error))
            }
        }
    }
}
