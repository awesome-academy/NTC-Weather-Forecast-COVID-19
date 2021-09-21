//
//  Extension+UIDatePicker.swift
//  NTC-Weather-Forecast-COVID-19
//
//  Created by trần nam on 9/21/21.
//

import Foundation
import UIKit

extension UIDatePicker {
    func setMinMaxTime(min: String, max: String) {
        minimumDate = DateFormatter().convertStringToDate(string: min)
        maximumDate = DateFormatter().convertStringToDate(string: max)
    }
}
