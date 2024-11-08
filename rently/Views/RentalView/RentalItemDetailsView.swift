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
            Image("vintage_skirt") // Replace with actual image if available in rental data
                .resizable()
                .frame(width: 80, height: 80)
                .cornerRadius(8)

            VStack(alignment: .leading, spacing: 4) {
              
                Text("Renter: \(viewModel.renter?.username ?? "Unknown")")
                    .font(.subheadline)
                    .foregroundColor(.gray)
                Text("Vintage guess skirt") // Replace with rental item name if available
                    .font(.title3)
                    .fontWeight(.bold)
                Text("\(formattedDate(rental.startDate)) - \(formattedDate(rental.endDate))")
                    .font(.subheadline)
                    .foregroundColor(.gray)
            }
        }
        .padding(.horizontal)
        .onAppear {
            print("RentalItemDetailsView appeared, loading renter details for rental: \(rental)")
            viewModel.loadRenterDetails(rental: rental)
        }
    }

    private func formattedDate(_ date: Date) -> String {
        let formatter = DateFormatter()
        formatter.dateStyle = .short
        return formatter.string(from: date)
    }
}
