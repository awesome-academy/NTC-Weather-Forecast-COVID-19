//
//  SearchCountryViewController.swift
//  NTC-Weather-Forecast-COVID-19
//
//  Created by trần nam on 9/15/21.
//

import UIKit

protocol SearchCountryDelegate: AnyObject {
    func sendCountry(country: Country)
}

final class SearchCountryViewController: UIViewController {
    
    @IBOutlet private weak var searchCountrySearchBar: UISearchBar!
    @IBOutlet private weak var listCountryTableView: UITableView!
    
    private let refreshControl = UIRefreshControl()
    private var countries = [Country]()
    private var listSearchCountry = [Country]()
    weak var delegate: SearchCountryDelegate?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        dismissKeyboard()
        setup()
        loadAPI()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        searchCountrySearchBar.becomeFirstResponder()
    }
    
    private func setup() {
        searchCountrySearchBar.delegate = self
        listCountryTableView.dataSource = self
        listCountryTableView.delegate = self
        listCountryTableView.register(SearchCountryTableViewCell.nib,
                                      forCellReuseIdentifier: SearchCountryTableViewCell.reuseIdentifier)
        refreshControl.attributedTitle = NSAttributedString()
        refreshControl.addTarget(self,
                                 action: #selector(refresh(_:)),
                                 for: .valueChanged)
        listCountryTableView.addSubview(refreshControl)
    }
    
    private func loadAPI() {
        Covid19APIService.shared.getListCountry { result in
            switch result {
            case .success(let countries):
                self.countries = countries
                self.listSearchCountry = countries
                DispatchQueue.main.async { [weak self] in
                    guard let self = self else { return }
                    self.listCountryTableView.reloadData()
                }
            case .failure(let error):
                print(error)
            }
        }
    }
    
    @objc private func refresh(_ sender: AnyObject) {
        loadAPI()
        refreshControl.endRefreshing()
    }
    
    private func searchName(nameCountry: String) {
        listSearchCountry.removeAll()
        listSearchCountry = nameCountry.isEmpty
            ? countries : countries.filter { $0.name.contains(nameCountry) }
        listCountryTableView.reloadData()
    }
    
    @IBAction
    private func clickCancelButton(_ sender: UIButton) {
        dismiss(animated: true, completion: nil)
    }
}

extension SearchCountryViewController: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return listSearchCountry.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        if let cell = tableView.dequeueReusableCell(
            withIdentifier: SearchCountryTableViewCell.reuseIdentifier)
            as? SearchCountryTableViewCell {
            let country = listSearchCountry[indexPath.row]
            cell.configView(country: country)
            return cell
        }
        return UITableViewCell()
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
        delegate?.sendCountry(country: listSearchCountry[indexPath.row])
        dismiss(animated: true, completion: nil)
    }
}

extension SearchCountryViewController: UISearchBarDelegate {
    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
        guard let name = searchBar.searchTextField.text else {
            return
        }
        searchName(nameCountry: name)
    }
    
    func searchBarSearchButtonClicked(_ searchBar: UISearchBar) {
        searchBar.endEditing(true)
        guard let name = searchBar.searchTextField.text else {
            return
        }
        searchName(nameCountry: name)
    }
}
