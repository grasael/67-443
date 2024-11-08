//
//  RentalTimelineView.swift
//  rently
//
//  Created by Tishyaa Chaudhry on 11/4/24.
//

import Foundation
import SwiftUI

struct RentalTimelineView: View {
    var rental: Rental // Add rental property
    
    var body: some View {
        VStack(spacing: 8) {
            HStack {
                // Pickup Section
                VStack {
                    Image(systemName: isDatePassed(rental.startDate) ? "checkmark.circle.fill" : "circle")
                        .foregroundColor(isDatePassed(rental.startDate) ? .green : .gray)
                    Text("Pickup")
                        .font(.caption)
                    Text("\(formattedDate(rental.startDate))")
                        .font(.caption2)
                        .foregroundColor(.gray)
                    Text("@ \(rental.pickupLocation)")
                        .font(.caption2)
                        .foregroundColor(.gray)
                }
                
                Spacer()
                
                // Dropoff Section
                VStack {
                    Image(systemName: isDatePassed(rental.endDate) ? "checkmark.circle.fill" : "circle")
                        .foregroundColor(isDatePassed(rental.endDate) ? .green : .gray)
                    Text("Dropoff")
                        .font(.caption)
                    Text("\(formattedDate(rental.endDate))")
                        .font(.caption2)
                        .foregroundColor(.gray)
                    Text("@ \(rental.pickupLocation)")
                        .font(.caption2)
                        .foregroundColor(.gray)
                }
                
                Spacer()
                
                // Verification Section
                VStack {
                    Image(systemName: "circle")
                        .foregroundColor(.gray)
                    Text("Verification")
                        .font(.caption)
                    Text("")
                }
            }
        }
        .padding(.horizontal)
        .padding(.vertical, 8)
        .background(RoundedRectangle(cornerRadius: 8).stroke(Color.gray, lineWidth: 1))
        .padding(.horizontal)
    }
    
    private func formattedDate(_ date: Date) -> String {
        let formatter = DateFormatter()
        formatter.dateStyle = .short
        return formatter.string(from: date)
    }
    
    private func isDatePassed(_ date: Date) -> Bool {
        return Date() > date
    }
}
