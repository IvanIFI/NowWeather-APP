//
//  LocationService.swift
//  NowWeather
//
//  Created by Ivan Ferre Insa on 10/12/25.
//

import CoreLocation

final class LocationService: NSObject, LocationServiceProtocol {
    
    weak var delegate: LocationServiceDelegate?
    private let manager = CLLocationManager()
    
    override init() {
        super.init()
        manager.delegate = self
    }
    
    func requestAuthorization() {
        manager.requestWhenInUseAuthorization()
    }
    
    func requestLocation() {
        manager.requestLocation()
    }
    
}

extension LocationService: CLLocationManagerDelegate {
    
    func locationManager(_ manager: CLLocationManager, didChangeAuthorization status: CLAuthorizationStatus) {
        delegate?.didChangeAuthorization(status: status)
    }
    
    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        guard let loc = locations.first else {
            delegate?.didFailLocation(error: .unableToFindLocation)
            return
        }

        delegate?.didUpdateLocation(lat: loc.coordinate.latitude,lon: loc.coordinate.longitude)
    }
    
    func locationManager(_ manager: CLLocationManager, didFailWithError error: Error) {
        delegate?.didFailLocation(error: .unknown)
    }
    
}


