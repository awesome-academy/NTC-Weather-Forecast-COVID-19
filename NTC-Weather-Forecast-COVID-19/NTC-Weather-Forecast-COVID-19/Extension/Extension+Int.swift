//
//  Extension+Int.swift
//  NTC-Weather-Forecast-COVID-19
//
//  Created by trần nam on 9/14/21.
//

import Foundation

extension Int {
    func toString() -> String {
        let formatter = NumberFormatter()
        formatter.numberStyle = .decimal
        formatter.maximumFractionDigits = 0
        let result = formatter.string(from: NSNumber(value: self))
        return result ?? "0"
    }
}
