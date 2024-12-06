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
    @State private var navigateToHome = false // Control navigation to HomeView

    var body: some View {
        NavigationStack {
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
                            navigateToHome = true
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

                // Navigation to Home View
                NavigationLink(
                    destination: HomeView(), // Replace with your actual home view
                    isActive: $navigateToHome
                ) {
                    EmptyView()
                }
            }
            .padding()
            .navigationBarBackButtonHidden(true) // Prevent back navigation
            .navigationBarTitle("Confirmation", displayMode: .inline) // Display title in navigation bar
            .toolbar {
                ToolbarItem(placement: .navigationBarLeading) {
                    Button(action: {
                        navigateToHome = true // Redirect to HomeView when tapping "X"
                    }) {
                        Image(systemName: "xmark")
                            .foregroundColor(.primary)
                    }
                }
            }
        }
    }

    private func formattedDate(_ date: Date) -> String {
        let formatter = DateFormatter()
        formatter.dateStyle = .medium
        return formatter.string(from: date)
    }
}
