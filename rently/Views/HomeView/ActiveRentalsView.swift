//
//  ActiveRentalsView.swift
//  rently
//
//  Created by Tishyaa Chaudhry on 11/2/24.
//

import Foundation
import SwiftUI

// MARK: - ActiveRentalsView
struct ActiveRentalsView: View {
    @EnvironmentObject var rentalViewModel: RentalViewModel
    @EnvironmentObject var listingsViewModel: ListingsViewModel

    var body: some View {
        // Check if there are active rentals before displaying the content
        if rentalViewModel.activeRentals.isEmpty {
            // Return an empty view or nothing if there are no active rentals
            EmptyView()
        } else {
            VStack(alignment: .leading, spacing: 10) {
                HStack {
                    Text("Your Active Rentals")
                        .font(.headline)
                    Spacer()
                    NavigationLink(destination: AllActiveRentalsView()
                        .environmentObject(rentalViewModel)
                        .environmentObject(listingsViewModel)) {
                    }
                }

                ScrollView(.horizontal, showsIndicators: false) {
                    HStack(spacing: 15) {
                        ForEach(rentalViewModel.activeRentals) { rental in
                            Text(rental.pickupLocation) // Simplify the content temporarily
                        }
                    }
                }
            }
            .onAppear {
                rentalViewModel.fetchActiveRentals() // Fetch rentals
            }
        }
    }
}
