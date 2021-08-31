//
//  Main.swift
//  NTC-Weather-Forecast-COVID-19
//
//  Created by trần nam on 8/30/21.
//

import Foundation

struct MainWeather: Codable {
    let temp: Double
    let humidity: Double
    
    init() {
        temp = 0
        humidity = 0
    }
    
    init(temp: Double, humidity: Double) {
        self.temp = temp
        self.humidity = humidity
    }
}
