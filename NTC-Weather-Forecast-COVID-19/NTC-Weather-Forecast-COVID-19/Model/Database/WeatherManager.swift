//
//  DataDetailWeatherManager.swift
//  NTC-Weather-Forecast-COVID-19
//
//  Created by trần nam on 9/9/21.
//

import Foundation

class WeatherManager {
    
    static let shared = WeatherManager()
    
    private init() {}
 
    private let weatherRepository = WeatherRepository()
    
    func createWeatherEntity(weather: WeatherEntity) {
        weatherRepository.createWeatherEntity(weather: weather)
    }
    
    func getAllWeatherEntity() -> [WeatherEntity] {
        return weatherRepository.getAllWeatherEntity()
    }
    
    func isWeatherEntity(weather: WeatherEntity) -> Bool {
        return weatherRepository.isWeatherEntity(weather: weather)
    }
    
    func deleteWeatherEntity(weather: WeatherEntity) {
        weatherRepository.deleteWeatherEntity(weather: weather)
    }
}
