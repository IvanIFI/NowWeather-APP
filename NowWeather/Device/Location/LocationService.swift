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
        switch status {
        case .denied, .restricted:
            delegate?.didFailLocation(error: .locationPermissionDenied)
        case .authorizedWhenInUse, .authorizedAlways:
            manager.requestLocation()
        default:
            break
        }
    }
    
    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        guard let loc = locations.first else {
            delegate?.didFailLocation(error: .unknown)
            return
        }
     
        delegate?.didUpdateLocation(lat: loc.coordinate.latitude, lon: loc.coordinate.longitude)
    }
    
    func locationManager(_ manager: CLLocationManager, didFailWithError error: Error) {
        delegate?.didFailLocation(error: .unknown)
    }
    
}


