//
//  WeatherLocationVC.swift
//  NowWeather
//
//  Created by Ivan Ferre Insa on 9/12/25.
//

import UIKit

class WeatherLocationVC: UIViewController {
    
    private lazy var weatherLocTableView = configMainTableView()
    private lazy var dataModelsOfCells: [any DrawerProtocol] = getUIModels()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setupUI()
    }
    
}

//MARK: - UI Configuration & Setup
private extension WeatherLocationVC {
    
    func setupUI() {
        view.backgroundColor = .white
        view.addSubview(weatherLocTableView)
        
        registerCells()
        configConstrains()
    }
    
    func configConstrains() {
        NSLayoutConstraint.activate([
            weatherLocTableView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 20),
            weatherLocTableView.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 20),
            weatherLocTableView.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -20),
            weatherLocTableView.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor, constant: -20)
        ])
    }
    
    func getUIModels() ->[any DrawerProtocol] {
        return[
            SearchEngineModel(
                placeholder: Constants.placeHolderSearchEngine),
            MainWeatherCellModel(
                ImageWeatherModel(image: "sun.max"),
                DateLabelModel(date: "10/12/2025"),
                TemperatureModel(temperature: "10º"))
        ]
    }
    
    // MARK: - Configuration views
    func configMainTableView() -> UITableView {
        let weatherLocationTableView = UITableView()
        weatherLocationTableView.separatorStyle = .none
        weatherLocationTableView.allowsSelection = false
        weatherLocationTableView.dataSource = self
        weatherLocationTableView.delegate = self
        weatherLocationTableView.translatesAutoresizingMaskIntoConstraints = false
        return weatherLocationTableView
    }
    
    func registerCells() {
        weatherLocTableView.register(UINib(nibName: "SearchEngineCell", bundle: nil), forCellReuseIdentifier: SearchEngineCell.reuseId)
        weatherLocTableView.register(UINib(nibName: "MainWeatherCell", bundle: nil), forCellReuseIdentifier: MainWeatherCell.reuseId)
    }
    
}

// MARK: - TableView
extension WeatherLocationVC: UITableViewDataSource, UITableViewDelegate {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return dataModelsOfCells.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard indexPath.row < dataModelsOfCells.count else { return UITableViewCell() }
        
        let cell = drawWithDrawerProtocol(tableView: tableView, rowsOfCells: dataModelsOfCells, indexPath: indexPath)
        return cell
    }
    
    private func drawWithDrawerProtocol(tableView: UITableView, rowsOfCells: [DrawerProtocol], indexPath: IndexPath) -> UITableViewCell {
        let currentRow = dataModelsOfCells[indexPath.row]
        let drawerOfCurrentRow = currentRow.cellDrawer
        let cell = drawerOfCurrentRow.tableView(tableView, cellForRowAt: indexPath)
        drawerOfCurrentRow.drawCell(cell, withItem: currentRow)
        cell.selectionStyle = .none
        return cell
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        let rowHeight = tableView.rowHeight
        let cell = dataModelsOfCells[indexPath.row]
        
        switch cell {
        case is SearchEngineModel:
            return 50
        case is MainWeatherCellModel:
            return 150
        default:
            return rowHeight
        }
        
    }
}
