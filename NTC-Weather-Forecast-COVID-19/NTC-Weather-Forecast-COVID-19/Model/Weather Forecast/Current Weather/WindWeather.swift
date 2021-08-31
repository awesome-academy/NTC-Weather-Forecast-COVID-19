//
//  Wind.swift
//  NTC-Weather-Forecast-COVID-19
//
//  Created by trần nam on 8/30/21.
//

import Foundation

struct WindWeather: Codable {
    let speed: Double
    
    init() {
        speed = 0
    }
    
    init(speed: Double) {
        self.speed = speed
    }
    
}
