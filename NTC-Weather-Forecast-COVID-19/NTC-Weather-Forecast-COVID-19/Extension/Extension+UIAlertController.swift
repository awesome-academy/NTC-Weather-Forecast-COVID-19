//
//  Extension+UIAlertController.swift
//  NTC-Weather-Forecast-COVID-19
//
//  Created by trần nam on 9/2/21.
//

import Foundation
import UIKit

extension UIAlertController {
    func showErrorAlert(title: String, message: String ) -> UIAlertController {
        let alert = UIAlertController(title: title, message: message, preferredStyle: .alert)
        let actionOk = UIAlertAction(title: "OK", style: .default)
        alert.addAction(actionOk)
        return alert
    }
}
