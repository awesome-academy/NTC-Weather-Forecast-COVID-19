//
//  SevenDaysWeather.swift
//  NTC-Weather-Forecast-COVID-19
//
//  Created by trần nam on 8/30/21.
//

import Foundation

struct SevenDaysWeather: Codable {
    var data: [Data7DaysWeather]
    
    init() {
        data = [Data7DaysWeather]()
    }
    
    init(data: [Data7DaysWeather]) {
        self.data = data
    }
}
