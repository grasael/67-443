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
    @StateObject private var rentalViewModel = ActiveRentalsViewModel()
    
    var body: some View {
        VStack(alignment: .leading, spacing: 10) {
            HStack {
                Text("your active rentals")
                    .font(.headline)
                Spacer()
                NavigationLink(destination: RentalsView()) {
                    Text("see all")
                        .foregroundColor(.blue)
                }
            }
            
            ScrollView(.horizontal, showsIndicators: false) {
                HStack(spacing: 15) {
                    ForEach(rentalViewModel.rentals) { rental in
                        if let listing = rentalViewModel.listing {
                            ActiveRentalCard(rental: rental, listing: listing)
                        } else {
                            Text("Loading...")
                        }
                    }
                }
                .padding(.vertical)
            }
        }
        .onAppear {
            rentalViewModel.fetchActiveRentals()
        }
    }
}

