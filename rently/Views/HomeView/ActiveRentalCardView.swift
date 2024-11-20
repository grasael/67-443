//
//  ActiveRentalCardView.swift
//  rently
//
//  Created by Tishyaa Chaudhry on 11/2/24.
//

import Foundation
import SwiftUI

// MARK: - ActiveRentalCard
struct ActiveRentalCard: View {
    var rental: Rental
    var listing: Listing
    
    var body: some View {
        NavigationLink(destination: RentalDetailView(rental: rental)) {
            HStack {
                VStack(alignment: .leading, spacing: 4) {
                    HStack {
                        Image(systemName: "calendar")
                        Text(rental.rentalStatusText)
                            .font(.subheadline)
                    }
                    Text("@ \(rental.pickupLocation), 12 pm")
                        .font(.footnote)
                        .foregroundColor(.gray)
                }
                Spacer()
                
                VStack(spacing: 8) {
                    // Image from the listing's first photo URL
                    if let firstImageURL = listing.photoURLs.first,
                       let url = URL(string: firstImageURL) {
                        AsyncImage(url: url) { phase in
                            switch phase {
                            case .empty:
                                // Placeholder while loading
                                ProgressView()
                                    .progressViewStyle(CircularProgressViewStyle())
                                    .frame(width: 60, height: 60)
                            case .success(let image):
                                image
                                    .resizable()
                                    .scaledToFill()
                                    .frame(width: 60, height: 60)
                                    .cornerRadius(8)
                            case .failure:
                                // Fallback if loading fails
                                Image(systemName: "photo")
                                    .resizable()
                                    .scaledToFill()
                                    .frame(width: 60, height: 60)
                                    .cornerRadius(8)
                            @unknown default:
                                EmptyView()
                            }
                        }
                    } else {
                        // Fallback if no photoURLs are available
                        Image(systemName: "photo")
                            .resizable()
                            .scaledToFill()
                            .frame(width: 60, height: 60)
                            .cornerRadius(8)
                    }
                    
                    // "view" button
                    Text("view")
                        .frame(width: 60, height: 30)
                        .background(Color.green)
                        .foregroundColor(.white)
                        .cornerRadius(8)
                }
                .frame(width: 60) // Ensure the button and image have consistent width
            }
            .padding()
            .background(Color.gray.opacity(0.1))
            .cornerRadius(12)
            .frame(width: 260)
        }
    }
}

