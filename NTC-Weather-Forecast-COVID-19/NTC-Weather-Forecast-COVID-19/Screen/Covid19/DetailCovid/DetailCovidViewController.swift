//
//  DetailCountryCovidViewController.swift
//  NTC-Weather-Forecast-COVID-19
//
//  Created by trần nam on 9/15/21.
//

import UIKit

final class DetailCovidViewController: UIViewController {
    
    @IBOutlet private weak var detailCountryCovidNavigationItem: UINavigationItem!
    @IBOutlet private weak var detailCountryCovidTableView: UITableView!
    
    var country = Country()
    var countryCovids = [CountryCovid]()
    private var countryCovidNoChange = [CountryCovid]()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setup()
    }
    
    private func setup() {
        detailCountryCovidTableView.delegate = self
        detailCountryCovidTableView.dataSource = self
        detailCountryCovidTableView.register(DetailCovidTableViewCell.nib,
                                             forCellReuseIdentifier: DetailCovidTableViewCell.reuseIdentifier)
        detailCountryCovidNavigationItem.title = country.name
        countryCovidNoChange = countryCovids
    }
    
    @IBAction
    private func actionFitlerDetailCountryCovid(_ sender: UIBarButtonItem) {
        self.performSegue(withIdentifier: "ChooseDateViewController", sender: nil)
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if let controller = segue.destination as? ChooseDateViewController {
            controller.delegate = self
            controller.countryCovids = self.countryCovidNoChange
        }
    }
}

extension DetailCovidViewController: UITableViewDataSource, UITableViewDelegate {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return countryCovids.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        if let cell = tableView.dequeueReusableCell(
            withIdentifier: DetailCovidTableViewCell.reuseIdentifier)
            as? DetailCovidTableViewCell {
            cell.configView(countryCovid: countryCovids[indexPath.row])
            return cell
        }
        return UITableViewCell()
    }
}

extension DetailCovidViewController: ChooseDateDelegate {
    func sendDate(date: Date) {
        countryCovids.removeAll()
        countryCovids = countryCovidNoChange.filter { $0.date.subStringTime() == DateFormatter().covertDateToString(date: date) }
        detailCountryCovidTableView.reloadData()
    }
}
