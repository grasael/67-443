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
    
    var body: some View {
        NavigationLink(destination: RentalDetailView(rental: rental)) {
            HStack {
                VStack(alignment: .leading, spacing: 4) {
                    HStack {
                        Image(systemName: "calendar")
                        Text(rental.rentalStatusText)
                            .font(.subheadline)
                    }
                    Text("@ \(rental.pickupLocation)")
                        .font(.footnote)
                        .foregroundColor(.gray)
                }
                Spacer()
                Image("sampleItemImage")
                    .resizable()
                    .scaledToFill()
                    .frame(width: 60, height: 60)
                    .cornerRadius(8)
                Text("view")
                    .frame(width: 60, height: 30)
                    .background(Color.green)
                    .foregroundColor(.white)
                    .cornerRadius(8)
            }
            .padding()
            .background(Color.gray.opacity(0.1))
            .cornerRadius(12)
            .frame(width: 260)
        }
    }
}

