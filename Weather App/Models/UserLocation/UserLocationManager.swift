//
//  UserLocationManager.swift
//  Weather App
//
//  Created by Bugra Aslan on 2.06.2024.
//

import Foundation
import CoreLocation

final class UserLocationManager: NSObject, ObservableObject, CLLocationManagerDelegate {
    @Published var userLocation: CLLocationCoordinate2D?
    private var locationManager = CLLocationManager()
    
    override init() {
        super.init()
        self.locationManager.delegate = self
        // 3km is enough for current location weather information
        self.locationManager.desiredAccuracy = kCLLocationAccuracyThreeKilometers
        // Request the user to authorize accesing the location when in use
        self.locationManager.requestWhenInUseAuthorization()
        // Try to start updating location if already authorized
        // self.locationManager.startMonitoringSignificantLocationChanges()
        // self.locationManager.startUpdatingLocation()
        self.locationManager.startMonitoringSignificantLocationChanges()
    }
    
    func locationManagerDidChangeAuthorization(_ manager: CLLocationManager) {
        let auth = manager.authorizationStatus
        if  auth == .authorizedAlways || auth == .authorizedWhenInUse {
            userLocation = locationManager.location?.coordinate
        }
    }
    
    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        guard let location = locations.last else { return }
        // Update published variable with user location coordinates
        userLocation = location.coordinate
    }
}

extension CLLocationCoordinate2D: Equatable {
    static public func ==(lhs: CLLocationCoordinate2D, rhs: CLLocationCoordinate2D) -> Bool {
        return lhs.latitude == rhs.latitude && lhs.longitude == rhs.longitude
    }
}
