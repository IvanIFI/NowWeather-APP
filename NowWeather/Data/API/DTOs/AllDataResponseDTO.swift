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
}

struct WeatherDescriptionDTO: Decodable {
    let description: String
}

struct MainTempDTO: Decodable {
    let temp: Double
}

