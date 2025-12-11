//
//  WeatherLocationProtocol.swift
//  NowWeather
//
//  Created by Ivan Ferre Insa on 9/12/25.
//

enum WeatherLocationState {
    case idle // FALTA: Saber si mantenerlo o quitarlo
    case loading
    case success(WeatherModel)
    case error(String)
}

protocol WeatherLocationViewModelDelegate: AnyObject {
    func didUpdateState(_ state: WeatherLocationState)
}
 
protocol WeatherLocationViewModelProtocol {
    var delegate: WeatherLocationViewModelDelegate? { get set }
    
    func loadWeatherByCity(cityName: String)
    func loadWeatherByLocation(lat: Double, lon: Double)
}
