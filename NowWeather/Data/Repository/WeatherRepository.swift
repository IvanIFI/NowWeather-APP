//
//  WeatherRepository.swift
//  NowWeather
//
//  Created by Ivan Ferre Insa on 10/12/25.
//

import Foundation
 
final class WeatherRepository: WeatherRepositoryProtocol {
    
    private let service: WeatherAPIServiceProtocol
 
    init(service: WeatherAPIServiceProtocol) {
        self.service = service
    }
 
    func getWeatherByCityName(cityName: String) async throws -> WeatherModel {
        let weatherDTO = try await service.getWeatherByCityName(city: cityName)
        return WeatherMapper.map(dtoResponse: weatherDTO)
    }
    
    func getWeatherByLocation(lat: Double, lon: Double) async throws -> WeatherModel {
        let weatherDTO = try await service.getWeatherByLocatoin(lat: lat, lon: lon)
        return WeatherMapper.map(dtoResponse: weatherDTO)
    }

}

 
