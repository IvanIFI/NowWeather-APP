//
//  WeatherRespondeDTO.swift
//  NowWeather
//
//  Created by Ivan Ferre Insa on 10/12/25.
//

struct AllDataResponseDTO: Decodable {
    let weather: [WeatherDescriptionDTO]
    let main: MainTempDTO
    let name: String
    let dt: Int
}

struct WeatherDescriptionDTO: Decodable {
    let description: String
    let icon: String
}

struct MainTempDTO: Decodable {
    let temp: Double
}

