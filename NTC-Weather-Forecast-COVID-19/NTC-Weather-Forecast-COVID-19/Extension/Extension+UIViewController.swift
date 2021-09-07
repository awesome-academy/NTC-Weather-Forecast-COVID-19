//
//  Extension+UIViewController.swift
//  NTC-Weather-Forecast-COVID-19
//
//  Created by trần nam on 9/7/21.
//

import UIKit
import Foundation

extension UIViewController {
    func dismissKeyboard() {
        let tap = UITapGestureRecognizer(target: self,
                                         action: #selector(UIViewController.dismissKeyboardTouchOutside))
        tap.cancelsTouchesInView = false
        view.addGestureRecognizer(tap)
    }
        
    @objc private func dismissKeyboardTouchOutside() {
        view.endEditing(true)
    }
}
