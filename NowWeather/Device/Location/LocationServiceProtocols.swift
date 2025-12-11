//
//  LocationServiceProtocol.swift
//  NowWeather
//
//  Created by Ivan Ferre Insa on 10/12/25.
//

import CoreLocation

protocol LocationServiceDelegate: AnyObject {
    func didUpdateLocation(lat: Double, lon: Double)
    func didFailLocation(error: WeatherError)
}

protocol LocationServiceProtocol {
    var delegate: LocationServiceDelegate? { get set }
    func requestAuthorization()
    func requestLocation()
}
