//
//  DataDetailWeather.swift
//  NTC-Weather-Forecast-COVID-19
//
//  Created by trần nam on 8/30/21.
//

import Foundation

struct DataDetailWeather: Decodable {
    let weather: [Weather]
    let main: MainWeather
    let wind: WindWeather
    let time: CLong
    
    init() {
        weather = []
        main = MainWeather()
        wind = WindWeather()
        time = 0
    }
    
    enum CodingKeys: String, CodingKey {
        case weather
        case main
        case wind
        case time = "dt"
    }
}
