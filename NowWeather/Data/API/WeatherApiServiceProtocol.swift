//
//  WeatherApiServiceProtocol.swift
//  NowWeather
//
//  Created by Ivan Ferre Insa on 10/12/25.
//

protocol WeatherAPIServiceProtocol {
    func getWeatherByCityName(city: String) async throws -> AllDataResponseDTO
    func getWeatherByLocatoin(lat: Double, lon: Double) async throws -> AllDataResponseDTO
}
