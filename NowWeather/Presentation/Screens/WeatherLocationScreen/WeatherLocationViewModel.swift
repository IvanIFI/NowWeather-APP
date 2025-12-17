//
//  WeatherLocationViewModel.swift
//  NowWeather
//
//  Created by Ivan Ferre Insa on 9/12/25.
//

import Foundation

final class WeatherLocationViewModel: WeatherLocationViewModelProtocol {
    
    weak var delegate: WeatherLocationViewModelDelegate?
    private let repository: WeatherRepositoryProtocol
    
    init(repository: WeatherRepositoryProtocol) {
        self.repository = repository
    }
    
    func loadWeatherByCity(cityName: String) {
        updateState(state: .loading)
        
        Task {
            do {
                
                let model = try await repository.getWeatherByCityName(cityName: cityName)
                updateState(state: .success(model))
                
            } catch let error as WeatherError {
                handleWeatherError(error: error)
            } catch {
                updateState(state: .error("Ha ocurrido un error inesperado."))
            }
        }
    }
    
    func loadWeatherByLocation(lat: Double, lon: Double) {
        updateState(state: .loading)
        
        Task {
            do {
                //FALTA: Quitarlo, es solo para prueba
                try await Task.sleep(nanoseconds: 800_000_000)
                
                let model = try await repository.getWeatherByLocation(lat: lat, lon: lon)
                updateState(state: .success(model))
                
            } catch let error as WeatherError {
                handleWeatherError(error: error)
            } catch {
                updateState(state: .error("Ha ocurrido un error inesperado."))
            }
        }
    }
    
    func notifyLocationError(error: WeatherError) {
        handleWeatherError(error: error)
    }
    
    private func updateState(state: WeatherLocationState) {
        DispatchQueue.main.async {
            self.delegate?.didUpdateState(state)
        }
    }
    
    private func handleWeatherError(error: WeatherError) {
        let message: String
        
        switch error {
        case .noInternet: message = Constants.NO_INTERNET_ERROR_MESSAGE
        case .cityNotFound: message = Constants.CITY_NOT_FOUND_ERROR_MESSAGE
        case .APIError: message = Constants.API_ERROR_MESSAGE
        case .locationPermissionDenied: message = Constants.LOCALITATION_DENIED_ERROR_MESSAGE
        case .unknown: message = Constants.UNKNOW_ERROR_MESSAGE
        }
        
        updateState(state: .error(message))
    }
    
}
