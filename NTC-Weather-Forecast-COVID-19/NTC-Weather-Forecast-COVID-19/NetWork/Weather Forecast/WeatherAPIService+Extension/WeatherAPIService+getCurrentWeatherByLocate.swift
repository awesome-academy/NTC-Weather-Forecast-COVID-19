//
//  WeatherAPIService+getCurrentWeatherByLocate.swift
//  NTC-Weather-Forecast-COVID-19
//
//  Created by trần nam on 8/31/21.
//

import Foundation

extension WeatherAPIService {
    func getCurrentWeatherByLocate(lat: Double, long: Double, completion: @escaping (Result<CurrentWeather, Error>) -> Void) {
        WeatherAPIService.shared.pullJSONData(url: URL(string: WeatherNetwork.shared.getCurrentWeather(lat: lat, long: long))) { (result) in
            switch result {
            case .success(let JSONData):
                let weatherData = try? JSONDecoder().decode(CurrentWeather.self, from: JSONData)
                if let weatherData = weatherData {
                    completion(.success(weatherData))
                }
            case .failure(let error):
                completion(.failure(error))
            }
        }
    }
}
