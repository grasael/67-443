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
                .frame(maxWidth: .infinity, alignment: .center)
                .padding(.top, 60)
                .padding(.bottom, 10)

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
                .foregroundColor(Color("MediumGreen"))

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
                    .foregroundColor(.white)
                    .font(.system(size: 14, weight: .semibold)) // Reduced font size
                    .background(
                        LinearGradient(
                            gradient: Gradient(colors: [Color("LightBlue"), Color("MediumGreen")]),
                            startPoint: .leading,
                            endPoint: .trailing
                        )
                    )
                    .cornerRadius(20)
            }
            .padding(.horizontal, 40) // Horizontal padding
            .frame(maxWidth: .infinity) // Make sure the button does not stretch too far
            .padding(.bottom, 20) // Added bottom padding to ensure no overlap with navbar

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
            .padding()
            .background(
                Color.white.opacity(0.9)
                    .cornerRadius(10)
                    .padding()
            )
            .navigationBarBackButtonHidden(false)
            .navigationBarTitle("", displayMode: .inline)
        }
        .padding(.horizontal, 30)
        .padding(.top, 16)
        .background(
            LinearGradient(
                gradient: Gradient(colors: [Color("LightestBlue"), Color("MediumGreen"), Color("Yellow")]),
                startPoint: .topLeading,
                endPoint: .bottomTrailing
            )
            .opacity(0.2)
        )
        .edgesIgnoringSafeArea(.all)
    }

    private func formattedDate(_ date: Date) -> String {
        let formatter = DateFormatter()
        formatter.dateStyle = .medium
        return formatter.string(from: date)
    }
}


struct ConfirmationView_Previews: PreviewProvider {
    static var previews: some View {
        let mockListing = Listing(
            id: "1",
            title: "Elegant Black Dress",
            creationTime: Date(),
            description: "A stylish black dress perfect for formal occasions.",
            category: .dresses,
            userID: "user123",
            size: .medium,
            price: 49.99,
            color: .black,
            condition: .veryGood,
            photoURLs: [],
            tags: [.formal, .classy],
            brand: "Gucci",
            maxRentalDuration: .oneMonth,
            pickupLocations: [.uc, .tepper],
            available: true
        )

        ConfirmationView(
            listing: mockListing,
            pickupDate: Date(),
            dropoffDate: Calendar.current.date(byAdding: .day, value: 7, to: Date()) ?? Date(),
            location: "Jared L. Cohon University Center"
        )
    }
}
