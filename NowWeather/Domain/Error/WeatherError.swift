//
//  WeatherError.swift
//  NowWeather
//
//  Created by Ivan Ferre Insa on 11/12/25.
//

enum WeatherError: Error {
    case noInternet
    case cityNotFound
    case APIError
    case locationPermissionDenied
    case unknown
}
