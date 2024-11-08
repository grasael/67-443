//
//  RentalPriceView.swift
//  rently
//
//  Created by Tishyaa Chaudhry on 11/4/24.
//

import Foundation
import SwiftUI

struct RentalPriceView: View {
    var rental: Rental // Add rental property
    
    var body: some View {
        VStack(alignment: .leading, spacing: 8) {
            HStack {
                Text("Item Price:")
                    .font(.subheadline)
                Spacer()
                Text("6 x $5/day") // Replace with calculated rental duration and price
                    .font(.subheadline)
                    .foregroundColor(.gray)
            }
            
            HStack {
                Text("Total:")
                    .font(.headline)
                Spacer()
                VStack(alignment: .trailing) {
                    Text("$30.00") // Replace with total calculated cost
                        .font(.headline)
                    HStack {
                        Image(systemName: "checkmark.circle.fill")
                            .foregroundColor(.green)
                        Text("$15 on \(formattedDate(rental.startDate))")
                            .font(.caption)
                            .foregroundColor(.gray)
                    }
                    HStack {
                        Image(systemName: "checkmark.circle.fill")
                            .foregroundColor(.green)
                        Text("$15 on \(formattedDate(rental.endDate))")
                            .font(.caption)
                            .foregroundColor(.gray)
                    }
                }
            }
        }
        .padding(.horizontal)
    }
    
    private func formattedDate(_ date: Date) -> String {
        let formatter = DateFormatter()
        formatter.dateStyle = .short
        return formatter.string(from: date)
    }
}
