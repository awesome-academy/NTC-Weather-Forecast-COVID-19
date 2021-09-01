//
//  SevenWeatherTableViewCell.swift
//  NTC-Weather-Forecast-COVID-19
//
//  Created by trần nam on 9/1/21.
//

import UIKit

final class SevenDaysWeatherTableViewCell: UITableViewCell {

    @IBOutlet private weak var sevenDaysWeatherView: UIView!
    @IBOutlet private weak var timeLable: UILabel!
    @IBOutlet private weak var iconImageView: UIImageView!
    @IBOutlet private weak var tempLable: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
    }
}
