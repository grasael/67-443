//
//  RentalRowView.swift
//  rently
//
//  Created by Tishyaa Chaudhry on 12/5/24.
//

import Foundation
import SwiftUI

struct RentalRowView: View {
    var rental: Rental
    var listing: Listing
    var isCompleted: Bool

    var body: some View {
        HStack {
            // Image
            if let imageUrl = listing.photoURLs.first {
                AsyncImage(url: URL(string: imageUrl)) { image in
                    image.resizable()
                         .scaledToFill()
                         .frame(width: 50, height: 50)
                         .clipShape(Rectangle())
                         .cornerRadius(8)
                } placeholder: {
                    Color.gray
                        .frame(width: 50, height: 50)
                        .cornerRadius(8)
                }
            }

            // Text Details
            VStack(alignment: .leading, spacing: 5) {

                Text(listing.title)
                    .font(.headline)

                // Format start and end dates
                Text("\(formattedDate(rental.startDate)) - \(formattedDate(rental.endDate))")
                    .font(.subheadline)
                    .foregroundColor(.secondary)
            }

            Spacer()

            // Completion Tag
            if isCompleted {
                Text("completed")
                    .font(.caption)
                    .foregroundColor(.gray)
                    .padding(5)
                    .background(Color.gray.opacity(0.2))
                    .cornerRadius(8)
            }
        }
        .padding()
    }

    // Format dates as strings
    private func formattedDate(_ date: Date) -> String {
        let dateFormatter = DateFormatter()
        dateFormatter.dateStyle = .short
        return dateFormatter.string(from: date)
    }
}
