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
        sevenDaysWeatherView.layer.cornerRadius = sevenDaysWeatherView.frame.height / 3
    }

    func configView(data7DaysWeather: Data7DaysWeather, indexTemp: Int) {
        let dateFormatCoordinate = DateFormatter()
        timeLabel.text = dateFormatCoordinate.dateFormatWeather(time: data7DaysWeather.time,
                                                                typeCurrentTime: false)
        
        let urlString = WeatherNetwork.shared.getIcon(icon: data7DaysWeather.weather.icon,
                                                      typeCurrentTime: false)
        if let url = URL(string: urlString) {
            iconImageView.setImage(from: url)
        }
        
        tempLabel.formatTemperature(temp: data7DaysWeather.temp, indexTemp: indexTemp)
    }
}
