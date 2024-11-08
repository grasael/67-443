//
//  ListingsProfileView.swift
//  rently
//
//  Created by Grace Liao on 11/8/24.
//

import SwiftUI

struct ListingsProfileView: View {
    // Mock data for now
    let listings = [
        MockListing(
            title: "Princess Polly romper",
            pricePerDay: 15.0,
            imageUrl: "romper", // Make sure you have an image named "romper" in assets
            tags: ["formal", "party"]
        ),
        MockListing(
            title: "Aritzia dress pants",
            pricePerDay: 20.0,
            imageUrl: "dress_pants", // Make sure you have an image named "dress_pants" in assets
            tags: ["business", "classy"]
        )
    ]

    // Grid layout with two columns
    let columns = [
        GridItem(.flexible()),
        GridItem(.flexible())
    ]

    var body: some View {
        ScrollView {
            LazyVGrid(columns: columns, spacing: 20) {
                ForEach(listings) { listing in
                    VStack(alignment: .leading, spacing: 8) {
                        // Image
                        Image(listing.imageUrl)
                            .resizable()
                            .aspectRatio(contentMode: .fill)
                            .frame(width: 150, height: 200)
                            .clipped()
                            .cornerRadius(10)

                        // Title
                        Text(listing.title)
                            .font(.headline)
                            .lineLimit(1)

                        // Price per day
                        Text("$\(listing.pricePerDay, specifier: "%.2f")/day")
                            .font(.subheadline)
                            .foregroundColor(.gray)

                        // Tags
                        HStack {
                            ForEach(listing.tags, id: \.self) { tag in
                                Text(tag)
                                    .font(.caption)
                                    .padding(4)
                                    .background(Color.gray.opacity(0.2))
                                    .cornerRadius(5)
                            }
                        }
                    }
                    .padding()
                    .background(Color.white)
                    .cornerRadius(12)
                    .shadow(radius: 4)
                }
            }
            .padding(.horizontal)
        }
    }
}

struct ListingsProfileView_Previews: PreviewProvider {
    static var previews: some View {
        ListingsProfileView()
    }
}
