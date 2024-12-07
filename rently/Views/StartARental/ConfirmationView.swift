//
//  ConfirmationView.swift
//  rently
//
//  Created by Tishyaa Chaudhry on 12/4/24.
//

import Foundation
import SwiftUI

struct ConfirmationView: View {
    var listing: Listing
    var pickupDate: Date
    var dropoffDate: Date
    var location: String

    @StateObject private var viewModel = RentalViewModel()
    @State private var ownerEmail: String? = nil
    @State private var navigateToRentalComplete = false

    var body: some View {
        VStack(alignment: .leading, spacing: 16) {
            Text("Confirmation")
                .font(.largeTitle)
                .fontWeight(.bold)

            // Pickup Details
            Text("Pickup Date:")
            Text("\(formattedDate(pickupDate))")
                .font(.subheadline)
            Text(location)
                .font(.subheadline)
                .foregroundColor(.secondary)

            // Dropoff Details
            Text("Dropoff Date:")
            Text("\(formattedDate(dropoffDate))")
                .font(.subheadline)
            Text(location)
                .font(.subheadline)
                .foregroundColor(.secondary)

            // Total Cost
            Text("Total:")
            Text("$\(viewModel.calculateTotalCost(for: listing, from: pickupDate, to: dropoffDate))")
                .font(.headline)
                .foregroundColor(.green)

            Spacer()

            // Send Request Button
            Button(action: {
                viewModel.createRental(
                    listing: listing,
                    pickupDate: pickupDate,
                    dropoffDate: dropoffDate,
                    location: location
                )

                viewModel.fetchUserEmail(for: listing.userID) { email in
                    DispatchQueue.main.async {
                        ownerEmail = email
                        navigateToRentalComplete = true
                    }
                }
            }) {
                Text("Send Request!")
                    .frame(maxWidth: .infinity)
                    .padding()
                    .background(Color.blue)
                    .foregroundColor(.white)
                    .cornerRadius(8)
            }

            // Navigation to Rental Complete View
            NavigationLink(
                destination: RentalCompleteView(
                    itemName: listing.title,
                    userEmail: ownerEmail ?? "",
                    pickupLocation: location,
                    pickupDate: pickupDate
                ),
                isActive: $navigateToRentalComplete
            ) {
                EmptyView()
            }
        }
        .padding()
        .navigationBarBackButtonHidden(false) // Allow back navigation
        .navigationBarTitle("Confirmation", displayMode: .inline) // Display title in navigation bar
    }

    private func formattedDate(_ date: Date) -> String {
        let formatter = DateFormatter()
        formatter.dateStyle = .medium
        return formatter.string(from: date)
    }
}
