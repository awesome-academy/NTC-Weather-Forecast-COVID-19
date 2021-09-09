//
//  Extension+UILabel.swift
//  NTC-Weather-Forecast-COVID-19
//
//  Created by trần nam on 9/9/21.
//

import Foundation
import UIKit

extension UILabel {
    func formatTemperature(temp: Double, indexTemp: Int) {
        let newTemp = (indexTemp == 0) ? temp : (temp + 273)
        text =  String(Int(round(newTemp))) + ((indexTemp == 0) ? "°C" : "°F")
    }
}
