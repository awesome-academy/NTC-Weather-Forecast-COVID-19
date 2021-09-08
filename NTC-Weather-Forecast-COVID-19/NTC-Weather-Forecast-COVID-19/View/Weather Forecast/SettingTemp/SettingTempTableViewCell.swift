//
//  SettingTempTableViewCell.swift
//  NTC-Weather-Forecast-COVID-19
//
//  Created by trần nam on 9/8/21.
//

import UIKit

final class SettingTempTableViewCell: UITableViewCell, ReusableView {

    @IBOutlet private weak var nameTempLabel: UILabel!
    @IBOutlet private weak var descripTempLabel: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
    }
    
    func configView(temp: [String]) {
        nameTempLabel.text = temp[0]
        descripTempLabel.text = temp[1]
    }
}
