//
//  LocationManager.swift
//  rently
//
//  Created by Grace Liao on 11/28/24.
//

import Foundation
import CoreLocation

class LocationManager: NSObject, ObservableObject, CLLocationManagerDelegate {
    private var manager = CLLocationManager()
    @Published var userLocation: CLLocation?

    init(mockLocation: CLLocation? = nil) {
        super.init()
        manager.delegate = self
        manager.desiredAccuracy = kCLLocationAccuracyBest

        if let mockLocation = mockLocation {
            // Use mock location for previews
            userLocation = mockLocation
        } else {
            // Request live location data
            checkAuthorizationStatus()
        }
    }

    func requestPermission() {
        if CLLocationManager.locationServicesEnabled() {
            print("Requesting location permissions...")
            manager.requestWhenInUseAuthorization() // This should trigger the pop-up
        } else {
            print("Location services are disabled.")
        }
    }
    
    private func checkAuthorizationStatus() {
        if CLLocationManager.locationServicesEnabled() {
            let status = manager.authorizationStatus
            print("Authorization status: \(status.rawValue)") // Debugging
            switch status {
            case .notDetermined:
                manager.requestWhenInUseAuthorization()
            case .denied, .restricted:
                print("Location access denied or restricted.")
            case .authorizedWhenInUse, .authorizedAlways:
                manager.startUpdatingLocation()
            @unknown default:
                print("Unknown authorization status.")
            }
        } else {
            print("Location services are disabled.")
        }
    }
    
    func locationManagerDidChangeAuthorization(_ manager: CLLocationManager) {
        switch manager.authorizationStatus {
        case .authorizedWhenInUse, .authorizedAlways:
            print("Location access granted.")
            manager.startUpdatingLocation()
        case .denied:
            print("Location access denied.")
        case .restricted:
            print("Location access restricted.")
        case .notDetermined:
            print("Location permission not determined.")
        @unknown default:
            print("Unknown authorization status.")
        }
    }

    func locationManager(_ manager: CLLocationManager, didFailWithError error: Error) {
        print("Error getting location: \(error.localizedDescription)")
    }


    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        guard let location = locations.last else { return }
        userLocation = location
    }
}
