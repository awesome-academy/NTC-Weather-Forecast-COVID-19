//
//  ViewControllerWeather.swift
//  NTC-Weather-Forecast-COVID-19
//
//  Created by trần nam on 8/30/21.
//

import UIKit

final class WeatherViewController: UIViewController {
    
    @IBOutlet private weak var cityLabel: UILabel!
    @IBOutlet private weak var countryLabel: UILabel!
    @IBOutlet private weak var timeLabel: UILabel!
    @IBOutlet private weak var iconImageView: UIImageView!
    @IBOutlet private weak var descriptionLabel: UILabel!
    @IBOutlet private weak var tempLabel: UILabel!
    @IBOutlet private weak var humidityLabel: UILabel!
    @IBOutlet private weak var windSpeedLabel: UILabel!
    @IBOutlet private weak var sevenWeatherTableView: UITableView!
    private var city = CityWorld()
    private var sevenDaysWeather = SevenDaysWeather()
    private var currentWeather = CurrentWeather()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setup()
        loadAPI()
    }
    
    private func setup() {
        sevenWeatherTableView.dataSource = self
    }
    
    private func loadAPI() {
        let lat = Double(city.lat) ?? 0
        let long = Double(city.long) ?? 0
        let dispatchGroup = DispatchGroup()
        dispatchGroup.enter()
        WeatherAPIService.shared.getCurrentWeatherByLocate(lat: lat, long: long) { [weak self] result in
            guard let self = self else { return }
            switch result {
            case .success(let currentWeather):
                self.currentWeather = currentWeather
                dispatchGroup.leave()
            case .failure(let error):
                print(error)
            }
        }
        
        dispatchGroup.enter()
        WeatherAPIService.shared.get7DaysWeather(lat: lat, long: long) { [weak self] result in
            guard let self = self else { return }
            switch result {
            case .success(let sevenDaysWeather):
                self.sevenDaysWeather = sevenDaysWeather
                dispatchGroup.leave()
            case .failure(let error):
                print(error)
            }
        }
        
        dispatchGroup.notify(queue: .main) { [weak self] in
            guard let self = self else { return }
            self.loadData()
            self.sevenWeatherTableView.reloadData()
        }
    }
    
    private func loadData() {
        cityLabel.text = city.city
        countryLabel.text = city.country
        if currentWeather.weather.isEmpty {
            let errorAlert = UIAlertController().showErrorAlert(title: "Notice",
                                                                message: "Not data weather of this City!")
            present(errorAlert, animated: true, completion: nil)
        } else {
            let urlString = WeatherNetwork.shared.getIcon(icon: currentWeather.weather.first?.icon ?? "",
                                                          typeCurrentTime: true)
            if let url = URL(string: urlString) {
                iconImageView.setImage(from: url)
            }
            descriptionLabel.text = currentWeather.weather.first?.description.uppercased()
            tempLabel.text = String(Int(round(currentWeather.main.temp - 273))) + "°C"
            humidityLabel.text = String(currentWeather.main.humidity) + "%"
            windSpeedLabel.text = String(currentWeather.wind.speed) + " m/s"

            let dateFormatCoordinate = DateFormatter()
            timeLabel.text = dateFormatCoordinate.dateFormatWeather(time: currentWeather.time,
                                                                    typeCurrentTime: true)
        }
    }
    
    @IBAction
    private func clickSettingButton(_ sender: UIBarButtonItem) {
        performSegue(withIdentifier: "SettingTempViewController", sender: nil)
    }
    
    @IBAction
    private func clickGoToSearchCityScreenButton(_ sender: UIBarButtonItem) {
        performSegue(withIdentifier: "SearchCityViewController", sender: nil)
    }
    
    @IBAction
    private func clickSeeDetailButton(_ sender: UIButton) {
        if let detailWeatherScreen = storyboard?.instantiateViewController(identifier: "DetailWeatherViewController")
            as? DetailWeatherViewController {
            navigationController?.pushViewController(detailWeatherScreen, animated: true)
        } else {
            print("Error click See Detail")
        }
    }
}

extension WeatherViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return sevenDaysWeather.data.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        if let cell = tableView.dequeueReusableCell(
            withIdentifier: SevenDaysWeatherTableViewCell.reuseIdentifier)
            as? SevenDaysWeatherTableViewCell {
            cell.initDataUI(data7DaysWeather: sevenDaysWeather.data[indexPath.row])
            return cell
        } else {
            print("DequeueReusableCell failed while casting")
        }
        return UITableViewCell()
    }
}
