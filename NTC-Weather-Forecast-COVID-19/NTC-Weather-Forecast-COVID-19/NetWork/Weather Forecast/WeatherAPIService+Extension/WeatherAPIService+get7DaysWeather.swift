//
//  WeatherAPIService+get7DaysWeather.swift
//  NTC-Weather-Forecast-COVID-19
//
//  Created by trần nam on 8/31/21.
//

import Foundation

extension WeatherAPIService {
    func get7DaysWeather(lat: Double, long: Double, completion: @escaping (Result<SevenDaysWeather, Error>) -> Void) {
        WeatherAPIService.shared.pullJSONData(url: URL(string: WeatherNetwork.shared.get7DaysWeather(lat: lat, long: long))) { (result) in
            switch result {
            case .success(let JSONData):
                let sevenDaysWeatherData = try? JSONDecoder().decode(SevenDaysWeather.self, from: JSONData)
                if let sevenDaysWeatherData = sevenDaysWeatherData {
                    completion(.success(sevenDaysWeatherData))
                }
            case .failure(let error):
                completion(.failure(error))
            }
        }
    }
}
