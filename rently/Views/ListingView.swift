//
//  ListingView.swift
//  rently
//
//  Created by Tishyaa Chaudhry on 11/7/24.
//

import Foundation
import SwiftUI


struct ListingView: View {
    var listing: Listing

    var body: some View {
        ScrollView {
            VStack(alignment: .leading, spacing: 16) {
                
                // Image Carousel with Adjusted Size
                TabView {
                    ForEach(listing.photoURLs, id: \.self) { photoURL in
                        AsyncImage(url: URL(string: photoURL)) { phase in
                            switch phase {
                            case .empty:
                                ProgressView()
                                    .frame(maxWidth: .infinity, maxHeight: 300)
                            case .success(let image):
                                image
                                    .resizable()
                                    .scaledToFill()
                                    .frame(maxWidth: .infinity, maxHeight: 300)
                                    .clipped()
                            case .failure:
                                Image("sampleItemImage")
                                    .resizable()
                                    .frame(maxWidth: .infinity, maxHeight: 300)
                                    .clipped()
                            @unknown default:
                                EmptyView()
                            }
                        }
                    }
                }
                .frame(height: 300) // Set fixed height for the carousel
                .tabViewStyle(PageTabViewStyle(indexDisplayMode: .automatic)) // Carousel style
                
                // Title and Price
                Text(listing.title)
                    .font(.title)
                    .fontWeight(.bold)
                
                Text("$\(String(format: "%.2f", listing.price)) / day")
                    .font(.headline)
                    .foregroundColor(.green)
                
                // Brand and Condition
                HStack {
                    Text(listing.brand)
                        .font(.subheadline)
                        .foregroundColor(.secondary)
                    Spacer()
                    Text(listing.condition.rawValue.capitalized)
                        .font(.subheadline)
                        .padding(4)
                        .background(Color.gray.opacity(0.2))
                        .cornerRadius(4)
                }
                
                // Description
                Text(listing.description)
                    .font(.body)
                    .padding(.top, 8)

                // Size, Color, and Tags
                HStack {
                    Text("Size: \(listing.size.rawValue)")
                    Text("Color: \(listing.color.rawValue.capitalized)")
                }
                .font(.subheadline)
                .foregroundColor(.secondary)

                // Tags
                if !listing.tags.isEmpty {
                    HStack {
                        ForEach(listing.tags, id: \.self) { tag in
                            Text(tag.rawValue.capitalized)
                                .padding(4)
                                .background(Color.blue.opacity(0.1))
                                .cornerRadius(4)
                        }
                    }
                }

                // Rental Duration and Pickup Locations
                Text("Max Rental Duration: \(listing.maxRentalDuration.rawValue)")
                    .font(.subheadline)
                    .padding(.top, 8)
                
                Text("Pickup Locations:")
                    .font(.headline)
                    .padding(.top, 8)
                
                ForEach(listing.pickupLocations, id: \.self) { location in
                    Text(location.rawValue)
                        .font(.subheadline)
                        .foregroundColor(.secondary)
                }
                
                Spacer()
            }
            .padding()
        }
        .navigationBarTitle("Listing Details", displayMode: .inline)
        .navigationBarBackButtonHidden(false) // Ensure back button is visible
    }
}

struct ListingView_Previews: PreviewProvider {
    static var previews: some View {
        let sampleListing = Listing(
            id: "1",
            title: "Princess Polly Romper",
            creationTime: Date(),
            description: "Gorgeous Princess Polly romper, perfect for a picnic or a casual day out. Worn a few times and rented twice, still in very good condition. Please cold wash and air dry.",
            category: .dresses,
            userID: "user123",
            size: .small,
            price: 5.0,
            color: .black,
            condition: .veryGood,
            photoURLs: ["https://example.com/sample-image.jpg", "https://example.com/sample-image2.jpg"],
            tags: [.casual, .vintage],
            brand: "Princess Polly",
            maxRentalDuration: .oneWeek,
            pickupLocations: [.uc, .fifthClyde],
            available: true
        )

        ListingView(listing: sampleListing)
            .previewDevice("iPhone 14")
    }
}
