//
//  ListingDetailView.swift
//  rently
//
//  Created by Sara Riyad on 11/7/24.
//

import Foundation
import SwiftUI

struct ListingDetailView: View {
    let listing: Listing
    let user: User

    var body: some View {
        ScrollView {
            VStack(alignment: .leading) {
                // Listing Image
                if let urlString = listing.photoURLs.first, let url = URL(string: urlString) {
                    AsyncImage(url: url) { image in
                        image
                            .resizable()
                            .aspectRatio(contentMode: .fill)
                            .frame(height: 300)
                            .clipped()
                    } placeholder: {
                        ProgressView()
                    }
                }

                // User and Rating Information
                HStack(spacing: 10) {
                    // User's profile image placeholder (if you have it)
                    Circle()
                        .fill(Color.gray)
                        .frame(width: 50, height: 50)

                    VStack(alignment: .leading) {
                        Text(user.username)
                            .font(.headline)
                        HStack(spacing: 2) {
                            ForEach(0..<5) { star in
                                Image(systemName: star < Int(user.rating) ? "star.fill" : "star")
                                    .foregroundColor(star < Int(user.rating) ? .yellow : .gray)
                            }
                        }
                    }
                    Spacer()
                   /* Button(action: {
                        // Add like functionality here
                    }) {
                        Image(systemName: "heart")
                            .foregroundColor(.red)
                    }*/
                }
                .padding(.horizontal)

                // Listing Details
                Text(listing.title)
                    .font(.title)
                    .bold()
                    .padding(.horizontal)

                HStack {
                    Text(listing.brand)
                        .font(.subheadline)
                        .padding(5)
                        .background(Color.blue.opacity(0.2))
                        .cornerRadius(5)
                    Text(listing.condition)
                        .font(.subheadline)
                        .padding(5)
                        .background(Color.gray.opacity(0.2))
                        .cornerRadius(5)
                    Text(listing.category.rawValue)
                        .font(.subheadline)
                        .padding(5)
                        .background(Color.gray.opacity(0.2))
                        .cornerRadius(5)
                    Text("size \(listing.size.rawValue)")
                        .font(.subheadline)
                        .padding(5)
                        .background(Color.gray.opacity(0.2))
                        .cornerRadius(5)
                }
                .padding(.horizontal)

                Text(listing.description)
                    .padding(.horizontal)

                HStack {
                    Text("$\(String(format: "%.2f", listing.price))/day")
                        .font(.headline)
                    Spacer()
                    if listing.available {
                        Button(action: {
                            // Rent action here
                        }) {
                            Text("Rent")
                                .padding()
                                .background(Color.green)
                                .foregroundColor(.white)
                                .cornerRadius(10)
                        }
                    } else {
                        Text("Rented until \(formattedDate(listing.creationTime))")
                            .foregroundColor(.gray)
                    }
                }
                .padding(.horizontal)
                .padding(.top)
            }
        }
        .navigationTitle("Listing Details")
        .navigationBarTitleDisplayMode(.inline)
    }
    
    // Helper function to format the date
    private func formattedDate(_ date: Date) -> String {
        let formatter = DateFormatter()
        formatter.dateStyle = .short
        return formatter.string(from: date)
    }
}

#Preview {
    ListingDetailView()
}
