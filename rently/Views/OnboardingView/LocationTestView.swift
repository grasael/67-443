//
//  LocationTestView.swift
//  rently
//
//  Created by Grace Liao on 11/29/24.
//

import Foundation
import SwiftUI
import CoreLocation

struct LocationTestView: View {
    @StateObject private var locationManager = LocationManager()

    var body: some View {
        VStack {
            if let location = locationManager.userLocation {
                Text("Your location: \(location.coordinate.latitude), \(location.coordinate.longitude)")
            } else {
                Text("No location available")
            }

            Button("Request Location Access") {
                locationManager.requestPermission()
            }
        }
        .padding()
    }
}

struct LocationTestView_Previews: PreviewProvider {
    static var previews: some View {
        LocationTestView()
            .environmentObject(LocationManager(
                mockLocation: CLLocation(latitude: 37.7749, longitude: -122.4194) // San Francisco
            ))
    }
}
