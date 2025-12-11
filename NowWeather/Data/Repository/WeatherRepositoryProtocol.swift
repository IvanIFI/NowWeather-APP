//
//  Untitled.swift
//  NowWeather
//
//  Created by Ivan Ferre Insa on 10/12/25.
//

protocol WeatherRepositoryProtocol {
    func getWeather(city: String) async throws -> WeatherModel
}
