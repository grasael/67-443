//
//  RentalItemDetailsView.swift
//  rently
//
//  Created by Tishyaa Chaudhry on 11/4/24.
//


import Foundation
import SwiftUI

struct RentalItemDetailsView: View {
    @StateObject var viewModel: ActiveRentalsViewModel
    let rental: Rental

    init(rental: Rental, viewModel: ActiveRentalsViewModel = ActiveRentalsViewModel()) {
        self.rental = rental
        _viewModel = StateObject(wrappedValue: viewModel)
    }

    var body: some View {
        HStack(alignment: .top, spacing: 16) {
            if let imageURL = viewModel.listing?.photoURLs.first, !imageURL.isEmpty {
                AsyncImage(url: URL(string: imageURL)) { image in
                    image.resizable()
                } placeholder: {
                    Image(systemName: "photo")
                        .resizable()
                        .scaledToFit()
                        .frame(width: 80, height: 80)
                        .cornerRadius(8)
                }
                .frame(width: 80, height: 80)
                .cornerRadius(8)
            } else {
                Image(systemName: "photo")
                    .resizable()
                    .scaledToFit()
                    .frame(width: 80, height: 80)
                    .cornerRadius(8)
            }

            VStack(alignment: .leading, spacing: 4) {
                // Renter information
                Text("Renter: \(viewModel.renter?.username ?? "Unknown")")
                    .font(.subheadline)
                    .foregroundColor(.gray)
                
                // Listing title
                Text(viewModel.listing?.title ?? "Loading...")
                    .font(.title3)
                    .fontWeight(.bold)
                
                // Rental date range
                Text("\(formattedDate(rental.startDate)) - \(formattedDate(rental.endDate))")
                    .font(.subheadline)
                    .foregroundColor(.gray)
                
                // Listing brand and price (optional)
                if let brand = viewModel.listing?.brand {
                    Text("Brand: \(brand)")
                        .font(.subheadline)
                        .foregroundColor(.gray)
                }
                if let price = viewModel.listing?.price {
                    Text(String(format: "$%.2f per day", price))
                        .font(.subheadline)
                        .foregroundColor(.gray)
                }
            }
        }
        .padding(.horizontal)
        .onAppear {
            print("RentalItemDetailsView appeared, loading renter and listing details for rental: \(rental)")
            viewModel.loadRenterDetails(rental: rental)
            viewModel.loadListingDetails(rental: rental)
        }
    }

    private func formattedDate(_ date: Date) -> String {
        let formatter = DateFormatter()
        formatter.dateStyle = .short
        return formatter.string(from: date)
    }
}
