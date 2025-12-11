//
//  WeatherApiService.swift
//  NowWeather
//
//  Created by Ivan Ferre Insa on 10/12/25.
//

import Foundation
 
final class WeatherAPIService: WeatherAPIServiceProtocol {
 
    private let session: URLSession

    init(session: URLSession = .shared) {
        self.session = session
    }

    func getWeatherByCityName(city: String) async throws -> AllDataResponseDTO {
        let apiKey = Constants.API_KEY
        let units = Constants.UNITS_API
        let lang = Constants.LANG_API

        let urlString = "https://api.openweathermap.org/data/2.5/weather?q=\(city)&appid=\(apiKey)&units=\(units)&lang=\(lang)"
 
        guard let url = URL(string: urlString) else { throw URLError(.badURL) }

        let (data, response) = try await session.data(from: url)
        //FALTA: RECOGER EL ERROR CONCRETO?
        guard let httpResponse = response as? HTTPURLResponse, httpResponse.statusCode == 200 else { throw URLError(.badServerResponse) }

        //FALTA: Hacer un Do Cath para si hay un error en el parseo
        let dtoResponseDecoded = try JSONDecoder().decode(AllDataResponseDTO.self, from: data)
        return dtoResponseDecoded

    }
    
    func getWeatherByLocatoin(lat: Double, lon: Double) async throws -> AllDataResponseDTO {
        let apiKey = Constants.API_KEY
        let units = Constants.UNITS_API
        let lang = Constants.LANG_API

        let urlString = "https://api.openweathermap.org/data/2.5/weather?lat=\(lat)&lon=\(lon)&appid=\(apiKey)&units=\(units)&lang=\(lang)"
 
        guard let url = URL(string: urlString) else { throw URLError(.badURL) }
        
        let (data, response) = try await session.data(from: url)
        guard let httpResponse = response as? HTTPURLResponse, httpResponse.statusCode == 200 else { throw URLError(.badServerResponse) }
        
        let dtoResponseDecoded = try JSONDecoder().decode(AllDataResponseDTO.self, from: data)
        return dtoResponseDecoded
    }
    

}

 
