//
//  UserLocationManager.swift
//  Weather App
//
//  Created by Bugra Aslan on 2.06.2024.
//

import Foundation
import CoreLocation

extension CLLocationCoordinate2D: Equatable {}

public func ==(lhs: CLLocationCoordinate2D, rhs: CLLocationCoordinate2D) -> Bool {
    return lhs.latitude == rhs.latitude && lhs.longitude == rhs.longitude
}

final class UserLocationManager: NSObject, ObservableObject, CLLocationManagerDelegate {
    @Published var userLocation: CLLocationCoordinate2D?
    private var locationManager = CLLocationManager()
    
    override init() {
        super.init()
        self.locationManager.delegate = self
        // Request the user to authorize accesing the location when in use
        self.locationManager.requestWhenInUseAuthorization()
        // Try to start updating location if already authorized
        self.locationManager.startUpdatingLocation()
    }
    
    func locationManagerDidChangeAuthorization(_ manager: CLLocationManager) {
        let auth = manager.authorizationStatus
        if  auth == .authorizedAlways || auth == .authorizedWhenInUse {
            userLocation = locationManager.location?.coordinate
        }
    }
}
//    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
//        guard let location = locations.last else { return }
//        // Update published variable with user location coordinates
//        userLocation = location.coordinate
//    }
//    
//    func locationManager(_ manager: CLLocationManager, didChangeAuthorization status: CLAuthorizationStatus) {
//        if status == .authorizedWhenInUse || status == .authorizedAlways {
//            // If authorization status has changed to authorized
//            // start updating location
//            locationManager.startUpdatingLocation()
//        }
//    }
//}
//    func locationManagerDidChangeAuthorization(_ manager: CLLocationManager) {
//        // Handle changes in location authorization
//        let previousAuthorizationStatus = manager.authorizationStatus
//        manager.requestWhenInUseAuthorization()
//        if manager.authorizationStatus != previousAuthorizationStatus {
//            checkLocationAuthorization()
//        }
//    }
//
//    func checkIfLocationIsEnabled() {
//        if CLLocationManager.locationServicesEnabled() {
//            locationManager = CLLocationManager()
//            locationManager?.desiredAccuracy = kCLLocationAccuracyReduced
//            locationManager!.delegate = self
//        } else {
//            print("Show an alert letting them know this is off")
//        }
//    }
//
//    private func checkLocationAuthorization() {
//        guard let location = locationManager else {
//            return
//        }
//
//        switch location.authorizationStatus {
//        case .notDetermined:
//            print("Location authorization is not determined.")
//        case .restricted:
//            print("Location is restricted.")
//        case .denied:
//            print("Location permission denied.")
//        case .authorizedAlways, .authorizedWhenInUse:
//            guard let location = location.location else {
//                return
//            }
//        default:
//            break
//        }
//    }
//}
