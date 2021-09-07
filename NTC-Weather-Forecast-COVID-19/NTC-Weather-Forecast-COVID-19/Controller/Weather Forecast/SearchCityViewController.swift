//
//  SearchCityViewController.swift
//  NTC-Weather-Forecast-COVID-19
//
//  Created by trần nam on 9/1/21.
//

import UIKit

protocol SearchCityDelegate: AnyObject {
    func sendCity(city: CityWorld)
}

final class SearchCityViewController: UIViewController {

    @IBOutlet private weak var searchCitySearchBar: UISearchBar!
    @IBOutlet private weak var listCityTableView: UITableView!
    
    private let refreshControl = UIRefreshControl()
    private var locations: [CityWorld] = []
    private var listSearchCity = [CityWorld]()
    private var isLoading = false
    private let identifierCell = "SearchCityTableViewCell"
    weak var delegate: SearchCityDelegate?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        dismissKeyboard()
        setup()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        searchCitySearchBar.becomeFirstResponder()
    }
    
    private func setup() {
        searchCitySearchBar.delegate = self
        listCityTableView.dataSource = self
        listCityTableView.delegate = self
        locations = ReadDateCity.shared.loadLocationFromCSV()
        listSearchCity = locations
        refreshControl.attributedTitle = NSAttributedString()
        refreshControl.addTarget(self,
                                 action: #selector(refresh(_:)),
                                 for: .valueChanged)
        listCityTableView.addSubview(refreshControl)
    }
    
    @objc private func refresh(_ sender: AnyObject) {
        guard let name = searchCitySearchBar.searchTextField.text else {
            return
        }
        if !isLoading {
            isLoading = true
            searchName(nameCity: name)
            refreshControl.endRefreshing()
        }
    }
    
    private func searchName(nameCity: String) {
        listSearchCity.removeAll()
        listSearchCity =
            nameCity.isEmpty ? locations
            : locations.filter { $0.city.contains(nameCity) }
        listCityTableView.reloadData()
    }
    
    @IBAction
    private func clickCancelButton(_ sender: UIButton) {
        self.dismiss(animated: true, completion: nil)
    }
}

extension SearchCityViewController: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return listSearchCity.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        if let cell = tableView.dequeueReusableCell(withIdentifier: identifierCell) {
            let item = listSearchCity[indexPath.row]
            cell.textLabel?.text = item.city
            cell.detailTextLabel?.text = item.country
            return cell
        } else {
            print("DequeueReusableCell failed while casting")
        }
        return UITableViewCell()
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
        self.delegate?.sendCity(city: listSearchCity[indexPath.row])
        self.dismiss(animated: true, completion: nil)
    }
}

extension SearchCityViewController: UISearchBarDelegate {
    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
        guard let name = searchBar.searchTextField.text else {
            return
        }
        searchName(nameCity: name)
    }
    
    func searchBarSearchButtonClicked(_ searchBar: UISearchBar) {
        searchBar.endEditing(true)
        guard let name = searchBar.searchTextField.text else {
            return
        }
        if !isLoading {
            isLoading = true
            searchName(nameCity: name)
        }
    }
}
