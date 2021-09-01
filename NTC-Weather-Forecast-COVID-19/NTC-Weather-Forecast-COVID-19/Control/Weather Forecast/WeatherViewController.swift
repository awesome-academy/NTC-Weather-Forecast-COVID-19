//
//  ViewControllerWeather.swift
//  NTC-Weather-Forecast-COVID-19
//
//  Created by trần nam on 8/30/21.
//

import UIKit

final class WeatherViewController: UIViewController {
    
    @IBOutlet private weak var cityLable: UILabel!
    @IBOutlet private weak var countryLable: UILabel!
    @IBOutlet private weak var timeLable: UILabel!
    @IBOutlet private weak var iconImageView: UIImageView!
    @IBOutlet private weak var descriptionLable: UILabel!
    @IBOutlet private weak var tempLable: UILabel!
    @IBOutlet private weak var humidityLable: UILabel!
    @IBOutlet private weak var windSpeedLable: UILabel!
    @IBOutlet private weak var sevenWeatherTableView: UITableView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    @IBAction func click_SettingButton(_ sender: UIBarButtonItem) {
    }
    
    @IBAction func click_GoToSearchCityScreenButton(_ sender: UIBarButtonItem) {
    }
    
    @IBAction func click_SeeDetailButton(_ sender: UIButton) {
    }
}
