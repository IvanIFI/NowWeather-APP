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
        updateState(.loading)
        
        Task {
            do {
                let model = try await repository.getWeatherByCityName(cityName: cityName)
                updateState(.success(model))
                //FALTA: CATCH poner un case con diferentes errores?
            } catch {
                updateState(.error("No se pudo cargar el clima de esa ciudad."))
            }
        }
    }
    
    func loadWeatherByLocation(lat: Double, lon: Double) {
        updateState(.loading)
        
        Task {
            do {
                //FALTA: Quitarlo, es solo para prueba
                try await Task.sleep(nanoseconds: 800_000_000)
                
                let model = try await repository.getWeatherByLocation(lat: lat, lon: lon)
                updateState(.success(model))
                //FALTA: CATCH poner un case con diferentes errores?
            } catch {
                updateState(.error("No se pudo cargar el clima de tu ubicación."))
            }
        }
    }
    
    private func updateState(_ state: WeatherLocationState) {
        //FALTA: ponerlo en el reloadTable?
        DispatchQueue.main.async {
            self.delegate?.didUpdateState(state)
        }
    }
    
}
