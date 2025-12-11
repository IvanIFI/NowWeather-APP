//
//  LocationServiceProtocol.swift
//  NowWeather
//
//  Created by Ivan Ferre Insa on 10/12/25.
//

import CoreLocation

enum LocationError: Error {
    case permissionDenied
    case unableToFindLocation
    case unknown
}

protocol LocationServiceDelegate: AnyObject {
    func didUpdateLocation(lat: Double, lon: Double)
    func didFailLocation(error: LocationError)
    func didChangeAuthorization(status: CLAuthorizationStatus)
}

protocol LocationServiceProtocol {
    var delegate: LocationServiceDelegate? { get set }
    func requestAuthorization()
    func requestLocation()
}
