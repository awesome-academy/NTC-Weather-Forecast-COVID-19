//
//  UIViewCustom.swift
//  NTC-Weather-Forecast-COVID-19
//
//  Created by trần nam on 9/14/21.
//

import Foundation
import UIKit

final class CustomView: UIView {
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        setup()
    }
    
    private func setup() {
        setShawdow()
        layer.cornerRadius = 10
        layer.borderWidth = 1.5
        layer.borderColor = UIColor.gray.cgColor
    }
    
    private func setShawdow() {
        layer.shadowColor = UIColor.blue.cgColor
        layer.shadowOffset = CGSize(width: 0.0, height: 5.0)
        layer.shadowRadius = 5
        layer.shadowOpacity = 0.3
        clipsToBounds = true
        layer.masksToBounds = false
    }
}
