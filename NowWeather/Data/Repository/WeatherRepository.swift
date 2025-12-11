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
 
    func getWeather(city: String) async throws -> WeatherModel {
        let weatherDTO = try await service.getWeather(city: city)
        let weatherModel = WeatherMapper.map(dtoResponse: weatherDTO)

        return weatherModel
    }

}

 
