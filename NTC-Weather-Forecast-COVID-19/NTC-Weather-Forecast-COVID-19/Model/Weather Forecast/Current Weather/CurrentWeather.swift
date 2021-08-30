//
//  CurrentWeather.swift
//  NTC-Weather-Forecast-COVID-19
//
//  Created by trần nam on 8/30/21.
//

import Foundation

struct CurrentWeather: Codable {
    let weather: [Weather]
    let main: MainWeather
    let wind: WindWeather
    let time: CLong
    let nameCity: String
    
    init() {
        weather = []
        main = MainWeather()
        wind = WindWeather()
        time = 0
        nameCity = ""
    }

    init(weather: [Weather], main: MainWeather, wind: WindWeather, time: CLong, nameCity: String) {
        self.weather = weather
        self.main = main
        self.wind = wind
        self.time = time
        self.nameCity = nameCity
    }
    
    enum CodingKeys: String, CodingKey {
        case weather
        case main
        case wind
        case time = "dt"
        case nameCity = "name"
    }
}
