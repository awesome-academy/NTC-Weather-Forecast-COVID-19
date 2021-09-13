//
//  SaveWeatherTableViewCell.swift
//  NTC-Weather-Forecast-COVID-19
//
//  Created by trần nam on 9/13/21.
//

import UIKit

final class SaveWeatherTableViewCell: UITableViewCell, ReusableView {
    
    @IBOutlet private weak var iconImageView: UIImageView!
    @IBOutlet private weak var cityLabel: UILabel!
    @IBOutlet private weak var timeLabel: UILabel!
    @IBOutlet private weak var descriptionLabel: UILabel!
    @IBOutlet private weak var humidityLabel: UILabel!
    @IBOutlet private weak var windSpeedLabel: UILabel!
    @IBOutlet private weak var tempLabel: UILabel!
    @IBOutlet private weak var saveWeatherView: UIView!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        saveWeatherView.layer.cornerRadius = saveWeatherView.frame.height / 10
    }
    
    func configView(weather: WeatherEntity, indexTemp: Int) {
        cityLabel.text = weather.city
        let urlString = WeatherNetwork.shared.getIcon(icon: weather.icon,
                                                      typeCurrentTime: true)
        if let url = URL(string: urlString) {
            iconImageView.setImage(from: url)
        }
        let dateFormatCoordinate = DateFormatter()
        timeLabel.text = dateFormatCoordinate.dateFormatWeather(time: CLong(weather.time),
                                                                typeCurrentTime: true)
        descriptionLabel.text = weather.des
        humidityLabel.text =  "\(weather.humidity)%"
        tempLabel.formatTemperature(temp: weather.temp - 273,
                                    indexTemp: indexTemp)
        windSpeedLabel.text = "\(weather.speedWind) m/s"
    }
}
