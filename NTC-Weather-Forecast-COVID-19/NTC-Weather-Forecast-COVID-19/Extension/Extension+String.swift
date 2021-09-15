//
//  Extension+String.swift
//  NTC-Weather-Forecast-COVID-19
//
//  Created by trần nam on 9/14/21.
//

import Foundation

extension String {
    func subStringTime() -> String {
        let start = index(startIndex, offsetBy: 0)
        let end = index(startIndex, offsetBy: 9)
        let newSubString = self[start...end]
        return String(newSubString)
    }
}
