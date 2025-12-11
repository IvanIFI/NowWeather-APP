//
//  WeatherLocationVC.swift
//  NowWeather
//
//  Created by Ivan Ferre Insa on 9/12/25.
//

import UIKit
import CoreLocation

class WeatherLocationVC: UIViewController {
    
    private var locationService: LocationServiceProtocol?
    private var weatherLocViewModel: WeatherLocationViewModelProtocol?
    
    private lazy var weatherLocTableView = configMainTableView()
    private lazy var refreshTable = configRefreshTable()
    private lazy var loadingSpinner = configLoadingSpinner()
    private lazy var dataModelsOfCells: [any DrawerProtocol] = getUIModels()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        //FALTA: poner en coordinators?  y cambiar nombres??
        let service = WeatherAPIService()
        let repository = WeatherRepository(service: service)
        
        self.weatherLocViewModel = WeatherLocationViewModel(repository: repository)
        self.weatherLocViewModel?.delegate = self
        
        self.locationService = LocationService()
        self.locationService?.delegate = self
        
        self.locationService?.requestAuthorization()
        self.locationService?.requestLocation()
        
        setupUI()
    }
    
}

//MARK: - UI Configuration & Setup
private extension WeatherLocationVC {
    
    func setupUI() {
        view.backgroundColor = .white
        view.addSubview(weatherLocTableView)
        view.addSubview(loadingSpinner)
        
        registerCells()
        configConstrains()
    }
    
    func configConstrains() {
        NSLayoutConstraint.activate([
            weatherLocTableView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 20),
            weatherLocTableView.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 20),
            weatherLocTableView.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -20),
            weatherLocTableView.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor, constant: -20),
            
            loadingSpinner.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            loadingSpinner.centerYAnchor.constraint(equalTo: view.centerYAnchor)
        ])
    }
    
    func getUIModels() ->[any DrawerProtocol] {
        return[
            SearchEngineModel(
                placeholder: Constants.placeHolderSearchEngine),
            MainWeatherCellModel(
                ImageWeatherModel(image: "hourglass"),
                DateLabelModel(date: ""),
                TemperatureModel(temperature: ""),
                LocationLabelModel(location: ""),
                DescriptionLabelModel(description: ""))
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
        weatherLocationTableView.refreshControl = refreshTable
        return weatherLocationTableView
    }
    
    func registerCells() {
        weatherLocTableView.register(UINib(nibName: "SearchEngineCell", bundle: nil), forCellReuseIdentifier: SearchEngineCell.reuseId)
        weatherLocTableView.register(UINib(nibName: "MainWeatherCell", bundle: nil), forCellReuseIdentifier: MainWeatherCell.reuseId)
    }
    
    func configLoadingSpinner() -> UIActivityIndicatorView {
        let indicator = UIActivityIndicatorView(style: .large)
        indicator.hidesWhenStopped = true
        indicator.translatesAutoresizingMaskIntoConstraints = false
        return indicator
    }
    
    private func configRefreshTable() -> UIRefreshControl {
        let refresh = UIRefreshControl()
        refresh.addTarget(self, action: #selector(didPullToRefresh), for: .valueChanged)
        return refresh
    }
    
    //FALTA COLOCAR CORRECTAEMNTE
    @objc private func didPullToRefresh() {
        print("Refrescando...")
        locationService?.requestLocation()
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
            return 200
        default:
            return rowHeight
        }
    }
     
}


extension WeatherLocationVC: WeatherLocationViewModelDelegate {
 
    func didUpdateState(_ state: WeatherLocationState) {
 
        switch state {
        case .loading:
            if !refreshTable.isRefreshing {
                loadingSpinner.startAnimating()
            }
            
            print("Cargando datos...")
 
        case .success(let model):
            refreshTable.endRefreshing()
            loadingSpinner.stopAnimating()
            print("Datos recibidos OK:", model)

            //FALTA: Extraerlo a un metodo 
            dataModelsOfCells = [
                SearchEngineModel(placeholder: Constants.placeHolderSearchEngine),
                MainWeatherCellModel(
                    ImageWeatherModel(image: model.icon),
                    DateLabelModel(date: model.date),
                    TemperatureModel(temperature: "\(model.temperature)"),
                    LocationLabelModel(location: model.cityName),
                    DescriptionLabelModel(description: model.description))
            ]
            
            weatherLocTableView.reloadData()
 
        case .error(let message):
            print("Error:", message)
            //FALTA: Mostrar un alert con el mensaje de error
 
        case .idle:
            break
        }
    }
}

extension WeatherLocationVC: LocationServiceDelegate {
 
    func didUpdateLocation(lat: Double, lon: Double) {
        print("Coordenadas recibidas:", lat, lon)
        weatherLocViewModel?.loadWeatherByLocation(lat: lat, lon: lon)

    }
 
    func didFailLocation(error: LocationError) {
        print("Error de ubicación:", error)
    }
 
    func didChangeAuthorization(status: CLAuthorizationStatus) {
        if status == .authorizedWhenInUse || status == .authorizedAlways {
            locationService?.requestLocation()
        }
    }

}

