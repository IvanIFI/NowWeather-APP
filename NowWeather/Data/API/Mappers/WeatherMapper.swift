//
//  WeatherMapper.swift
//  NowWeather
//
//  Created by Ivan Ferre Insa on 10/12/25.
//

final class WeatherMapper {
    static func map(dtoResponse: AllDataResponseDTO) -> WeatherModel {
        let temp = Utils.formatTemperatura(temp: dtoResponse.main.temp)
        let desc = dtoResponse.weather.first?.description.capitalized ?? ""
        
        return WeatherModel(cityName: dtoResponse.name, temperature: temp,description: desc)
    }
}

/*
//FALTA: NO HARDCODEAR e INTENTAR DAR UNOS VALOR POR DEFECTO EN CASO DE ERROR PONER COMO OPTIONALS EN DTOS
extension WeatherModel {
    init(dtoResponse: AllDataResponseDTO) {
        self.cityName = dtoResponse.cityName ?? "Error"
        self.description = dtoResponse.weather?.first?.description ?? "No description"
        self.temperature = dtoResponse.main?.temp ?? ""
    }
} */
