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
 
    func loadInitialWeather() {
 
        delegate?.didUpdateState(.loading)
 
        Task {
            do {
                //FALTA: Ciudad HARDCODEADA (solo para pruebas)
                let model = try await repository.getWeather(city: "Bocairent")
                DispatchQueue.main.async {
                    self.delegate?.didUpdateState(.success(model))
                }
            } catch {
                //FALTA: CATCH poner un case con diferentes errores?
                delegate?.didUpdateState(.error("No se pudo cargar el tiempo"))
            }
        }
    }
}
