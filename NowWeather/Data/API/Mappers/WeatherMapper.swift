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
        let icon = Utils.iconForWeather(code: dtoResponse.weather.first?.icon ?? "")
        let date = Utils.formatDate(timestamp: dtoResponse.dt)
        
        return WeatherModel(cityName: dtoResponse.name, temperature: temp,description: desc,icon: icon, date: date)
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
