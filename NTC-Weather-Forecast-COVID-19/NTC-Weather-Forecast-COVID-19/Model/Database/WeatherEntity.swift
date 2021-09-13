//
//  DataDetailWeatherCDConvert.swift
//  NTC-Weather-Forecast-COVID-19
//
//  Created by trần nam on 9/9/21.
//

import Foundation

class WeatherEntity {
    var id: String
    var city: String
    var humidity: Double
    var icon: String
    var des: String
    var speedWind: Double
    var temp: Double
    var time: Double
    
    init() {
        id = ""
        city = ""
        humidity = 0
        icon = ""
        des = ""
        speedWind = 0
        temp = 0
        time = 0
    }
    
    init(id: String,
         city: String,
         humidity: Double,
         icon: String,
         des: String,
         speedWind: Double,
         temp: Double,
         time: Double) {
        self.id = id
        self.city = city
        self.humidity = humidity
        self.icon = icon
        self.des = des
        self.speedWind = speedWind
        self.temp = temp
        self.time = time
    }
}
