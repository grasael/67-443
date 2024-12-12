//
//  AllActiveRentalsView.swift
//  rently
//
//  Created by Grace Liao on 12/12/24.
//
import SwiftUI

struct AllActiveRentalsView: View {
    @EnvironmentObject var rentalViewModel: RentalViewModel

    var body: some View {
        ScrollView {
            VStack(alignment: .leading, spacing: 20) {
                // Header Text
                Text("your active rentals")
                    .font(.title)
                    .fontWeight(.semibold)
                    .padding(.horizontal)

                if rentalViewModel.activeRentals.isEmpty {
                    // Empty State View
                    VStack {
                        Image(systemName: "exclamationmark.triangle")
                            .font(.largeTitle)
                            .foregroundColor(.gray)
                            .padding(.bottom, 8)
                        Text("No active rentals.")
                            .font(.body)
                            .foregroundColor(.gray)
                    }
                    .frame(maxWidth: .infinity, minHeight: 200) // Centered message
                } else {
                    // Rentals List
                    LazyVStack(spacing: 15) {
                        ForEach(rentalViewModel.activeRentals) { rental in
                            ActiveRentalCard(rental: rental) // Reuse the card view
                                .padding(.horizontal)
                        }
                    }
                }
            }
            .padding(.top)
        }
        .navigationTitle("Active Rentals")
        .onAppear {
            print("Displaying all active rentals: \(rentalViewModel.activeRentals.count)")
        }
    }
}
