//
//  WeatherApiServiceProtocol.swift
//  NowWeather
//
//  Created by Ivan Ferre Insa on 10/12/25.
//

protocol WeatherAPIServiceProtocol {
    func getWeather(city: String) async throws -> AllDataResponseDTO
}
