//
//  SettingTemp.swift
//  NTC-Weather-Forecast-COVID-19
//
//  Created by trần nam on 9/7/21.
//

import Foundation

enum TempFormat: String, CaseIterable {
    case celsius = "Celcius ℃"
    case fahrenheit = "Tempreture ℉"
}

enum UserDefaultsKeys: String {
    case keyTempFomat = "TEMP_FORMAT_KEY"
}
