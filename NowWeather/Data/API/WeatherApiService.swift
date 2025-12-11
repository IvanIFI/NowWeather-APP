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
        
        guard let url = URL(string: urlString) else { throw WeatherError.APIError }
        
        do {
            
            let (data, response) = try await session.data(from: url)
            
            guard let httpResponse = response as? HTTPURLResponse else { throw WeatherError.APIError }
            
            switch httpResponse.statusCode {
            case 404: throw WeatherError.cityNotFound
            case 500...599: throw WeatherError.APIError
            case 200: break
            default: throw WeatherError.unknown
            }
            
            return try JSONDecoder().decode(AllDataResponseDTO.self, from: data)
            
        } catch let urlError as URLError {
            
            switch urlError.code {
            case .notConnectedToInternet: throw WeatherError.noInternet
            default: throw WeatherError.unknown
            }
            
        } catch { throw WeatherError.unknown }
        
    }
    
    func getWeatherByLocation(lat: Double, lon: Double) async throws -> AllDataResponseDTO {
        let apiKey = Constants.API_KEY
        let units = Constants.UNITS_API
        let lang = Constants.LANG_API
        
        let urlString = "https://api.openweathermap.org/data/2.5/weather?lat=\(lat)&lon=\(lon)&appid=\(apiKey)&units=\(units)&lang=\(lang)"
        
        guard let url = URL(string: urlString) else { throw WeatherError.APIError }
        
        do {
            
            let (data, response) = try await session.data(from: url)
            
            guard let httpResponse = response as? HTTPURLResponse else { throw WeatherError.APIError }
                        
            switch httpResponse.statusCode {
            case 404: throw WeatherError.cityNotFound
            case 500...599: throw WeatherError.APIError
            case 200: break
            default: throw WeatherError.unknown
            }
            
            return try JSONDecoder().decode(AllDataResponseDTO.self, from: data)
            
        } catch let urlError as URLError {
            
            switch urlError.code {
            case .notConnectedToInternet: throw WeatherError.noInternet
            default: throw WeatherError.unknown
            }
            
        } catch { throw WeatherError.unknown }
    }
    
}


