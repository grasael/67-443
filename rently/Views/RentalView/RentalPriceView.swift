//
//  RentalPriceView.swift
//  rently
//
//  Created by Tishyaa Chaudhry on 11/4/24.
//

import Foundation
import SwiftUI

struct RentalPriceView: View {
  @StateObject var viewModel: ActiveRentalsViewModel
  let rental: Rental

  init(rental: Rental, viewModel: ActiveRentalsViewModel = ActiveRentalsViewModel()) {
      self.rental = rental
      _viewModel = StateObject(wrappedValue: viewModel)
  }

    var body: some View {
        VStack(alignment: .leading, spacing: 8) {
            HStack {
                Text("Item Price:")
                    .font(.subheadline)
                Spacer()
                
                if let listing = viewModel.listing {
                    Text("\(rental.rentalDurationInDays) x $\(listing.price, specifier: "%.2f")/day")
                        .font(.subheadline)
                        .foregroundColor(.gray)
                } else {
                    Text("Loading...")
                        .font(.subheadline)
                        .foregroundColor(.gray)
                }
            }
            
            HStack {
                Text("Total:")
                    .font(.headline)
                Spacer()
                VStack(alignment: .trailing) {
                    if let listing = viewModel.listing {
                        Text("$\(rental.calculateTotalCost(for: listing), specifier: "%.2f")")
                            .font(.headline)
                        
                        HStack {
                            Image(systemName: "circle")
                                .foregroundColor(.gray)
                            Text("$\(rental.calculateTotalCost(for: listing) / 2, specifier: "%.2f") on \(formattedDate(rental.startDate))")
                                .font(.caption)
                                .foregroundColor(.gray)
                        }
                        HStack {
                            Image(systemName: "circle")
                                .foregroundColor(.gray)
                            Text("$\(rental.calculateTotalCost(for: listing) / 2, specifier: "%.2f") on \(formattedDate(rental.endDate))")
                                .font(.caption)
                                .foregroundColor(.gray)
                        }
                    } else {
                        Text("Loading...")
                            .font(.headline)
                    }
                }
            }
        }
        .padding(.horizontal)
        .onAppear {
            print("loading listing details for price calc")
            viewModel.loadListingDetails(rental: rental)
        }
    }
    
    private func formattedDate(_ date: Date) -> String {
        let formatter = DateFormatter()
        formatter.dateStyle = .short
        return formatter.string(from: date)
    }
}
