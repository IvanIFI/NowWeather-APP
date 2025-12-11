//
//  Untitled.swift
//  NowWeather
//
//  Created by Ivan Ferre Insa on 10/12/25.
//

protocol WeatherRepositoryProtocol {
    func getWeatherByCityName(cityName: String) async throws -> WeatherModel
    func getWeatherByLocation(lat: Double, lon: Double) async throws -> WeatherModel
}
