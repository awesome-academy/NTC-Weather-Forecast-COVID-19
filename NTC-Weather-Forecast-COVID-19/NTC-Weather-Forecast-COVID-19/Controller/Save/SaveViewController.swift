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
    private var indexTemp = 0
    
    override func viewDidLoad() {
        super.viewDidLoad()
        saveWeatherTableView.dataSource = self
        saveWeatherTableView.delegate = self
        saveWeatherTableView.register(SaveWeatherTableViewCell.nib,
                                      forCellReuseIdentifier: SaveWeatherTableViewCell.reuseIdentifier)
    }
    
    override func viewWillAppear(_ animated: Bool) {
        indexTemp = (UserDefaults.standard.value(forKey: keyTempFormat) as? Int) ?? 0
        weathers = WeatherManager.shared.getAllWeatherEntity()
        saveWeatherTableView.reloadData()
    }
    
    @IBAction
    private func clickNotificationSegmentedControl(_ sender: UISegmentedControl) {
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
