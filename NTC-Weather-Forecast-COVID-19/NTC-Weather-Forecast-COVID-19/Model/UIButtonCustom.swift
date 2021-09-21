//
//  UIButtonCustom.swift
//  NTC-Weather-Forecast-COVID-19
//
//  Created by trần nam on 9/21/21.
//

import Foundation
import UIKit

final class CustomButton: UIButton {
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        setup()
    }
    
    private func setup() {
        setShawdow()
        layer.cornerRadius = 7
        layer.borderWidth = 0.5
        layer.borderColor = UIColor.gray.cgColor
    }
    
    private func setShawdow() {
        layer.shadowColor = UIColor.black.cgColor
        layer.shadowOffset = CGSize(width: 0.0, height: 5.0)
        layer.shadowRadius = 5
        layer.shadowOpacity = 0.3
        clipsToBounds = true
        layer.masksToBounds = false
    }
}
