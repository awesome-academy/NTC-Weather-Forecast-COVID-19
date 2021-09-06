//
//  Extension+ReusableView.swift
//  NTC-Weather-Forecast-COVID-19
//
//  Created by trần nam on 9/5/21.
//
import Foundation

extension ReusableView {
    static var reuseIdentifier: String {
        return String(describing: self)
    }
}
