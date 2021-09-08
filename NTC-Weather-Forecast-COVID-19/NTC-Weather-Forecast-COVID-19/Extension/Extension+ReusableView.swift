//
//  Extension+ReusableView.swift
//  NTC-Weather-Forecast-COVID-19
//
//  Created by trần nam on 9/5/21.
//
import Foundation
import UIKit

extension ReusableView {
    static var reuseIdentifier: String {
        return String(describing: self)
    }
    
    static var nib: UINib {
        return UINib(nibName: reuseIdentifier, bundle: nil)
    }
}
