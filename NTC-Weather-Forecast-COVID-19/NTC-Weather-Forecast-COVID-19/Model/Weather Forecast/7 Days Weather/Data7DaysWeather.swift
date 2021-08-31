//
//  Data7DaysWeather.swift
//  NTC-Weather-Forecast-COVID-19
//
//  Created by trần nam on 8/30/21.
//

import Foundation

struct Data7DaysWeather: Codable {
    let time: CLong
    let weather: Weather
    let temp: Double
    
    init() {
        time = 0
        weather = Weather()
        temp = 0
    }
    
    init(time: CLong, weather: Weather, temp: Double) {
        self.time = time
        self.weather = weather
        self.temp = temp
    }
    
    enum CodingKeys: String, CodingKey {
        case time = "ts"
        case weather
        case temp
    }
}
