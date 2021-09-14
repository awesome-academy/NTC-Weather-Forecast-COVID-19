//
//  ViewControllerSave.swift
//  NTC-Weather-Forecast-COVID-19
//
//  Created by trần nam on 8/30/21.
//

import UIKit

final class SaveViewController: UIViewController {

    @IBOutlet private weak var notificationSegmentControl: UISegmentedControl!
    @IBOutlet private weak var saveWeatherTableView: UITableView!
    
    private var weathers = [WeatherEntity]()
    private let keyTempFormat = UserDefaultsKeys.keyTempFomat.rawValue
    private let keyNotification = UserDefaultsKeys.keyNotification.rawValue
    private var indexTemp = 0
    private var indexNotification = 0
    
    override func viewDidLoad() {
        super.viewDidLoad()
        saveWeatherTableView.dataSource = self
        saveWeatherTableView.delegate = self
        saveWeatherTableView.register(SaveWeatherTableViewCell.nib,
                                      forCellReuseIdentifier: SaveWeatherTableViewCell.reuseIdentifier)
    }
    
    override func viewWillAppear(_ animated: Bool) {
        indexTemp = (UserDefaults.standard.value(forKey: keyTempFormat) as? Int) ?? 0
        indexNotification = (UserDefaults.standard.value(forKey: keyNotification) as? Int) ?? 0
        weathers = WeatherManager.shared.getAllWeatherEntity()
        saveWeatherTableView.reloadData()
        checkSegment()
    }
    
    private func notificationWeather(indexNotification: Int) {
        NotificationLocal.shared.clearNotification()
        for weather in weathers {
            NotificationLocal.shared.create(title: "Upcoming events",
                                            body: weather.city,
                                            time: CLong(weather.time),
                                            indexNotification: indexNotification)
        }
    }
    
    @IBAction
    private func clickNotificationSegmentedControl(_ sender: UISegmentedControl) {
        let index = sender.selectedSegmentIndex
        notificationWeather(indexNotification: index)
        indexNotification = index
        UserDefaults.standard.set(indexNotification, forKey: keyNotification)
    }
    
    private func checkSegment() {
        let index = UserDefaults.standard.integer(forKey: keyNotification)
        notificationWeather(indexNotification: index)
        notificationSegmentControl.selectedSegmentIndex = index
        indexNotification = index
    }
    
}

extension SaveViewController: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return weathers.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        if let cell = tableView.dequeueReusableCell(
            withIdentifier: SaveWeatherTableViewCell.reuseIdentifier)
            as? SaveWeatherTableViewCell {
            cell.configView(weather: weathers[indexPath.row], indexTemp: indexTemp)
            return cell
        }
        return UITableViewCell()
    }
    
    func tableView(_ tableView: UITableView, trailingSwipeActionsConfigurationForRowAt indexPath: IndexPath) -> UISwipeActionsConfiguration? {
        let delete = UIContextualAction(style: .destructive, title: "Delete") { [weak self] (_, _, _) in
            guard let self = self else { return }
            WeatherManager.shared.deleteWeatherEntity(weather: self.weathers[indexPath.row])
            self.weathers.remove(at: indexPath.row)
            tableView.deleteRows(at: [indexPath], with: .middle)
        }
        return UISwipeActionsConfiguration(actions: [delete])
    }
    
    func tableView(_ tableView: UITableView, willDisplay cell: UITableViewCell, forRowAt indexPath: IndexPath) {
        cell.layer.transform = CATransform3DMakeScale(0.1, 0.1, 1)
        UIView.animate(withDuration: 0.5, animations: {
            cell.layer.transform = CATransform3DMakeScale(1.05, 1.05, 1)
            }, completion: { _ in
                UIView.animate(withDuration: 0.2, animations: {
                    cell.layer.transform = CATransform3DMakeScale(1, 1, 1)
                })
        })
    }
}
