//
//  SevenWeatherTableViewCell.swift
//  NTC-Weather-Forecast-COVID-19
//
//  Created by trần nam on 9/1/21.
//

import UIKit

final class SevenDaysWeatherTableViewCell: UITableViewCell, ReusableView {

    @IBOutlet private weak var sevenDaysWeatherView: UIView!
    @IBOutlet private weak var timeLabel: UILabel!
    @IBOutlet private weak var iconImageView: UIImageView!
    @IBOutlet private weak var tempLabel: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
    }

    func initDataUI(data7DaysWeather: Data7DaysWeather) {
        sevenDaysWeatherView.layer.cornerRadius = sevenDaysWeatherView.frame.height / 3
        let dateFormatCoordinate = DateFormatter()
        timeLabel.text = dateFormatCoordinate.dateFormatWeather(time: data7DaysWeather.time,
                                                                typeCurrentTime: false)
        
        let urlString = WeatherNetwork.shared.getIcon(icon: data7DaysWeather.weather.icon,
                                                      typeCurrentTime: false)
        if let url = URL(string: urlString) {
            iconImageView.setImage(from: url)
        }
        tempLabel.text = String(Int(round(data7DaysWeather.temp))) + "°C"
    }
}
