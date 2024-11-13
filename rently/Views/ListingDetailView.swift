//
//  ListingDetailView.swift
//  rently
//
//  Created by Sara Riyad on 11/7/24.
//

import Foundation
import SwiftUI

struct ListingDetailView: View {
    let listingID: UUID
    @StateObject private var viewModel = ListingDetailViewModel()

    var body: some View {
        VStack {
            if let listing = viewModel.listing {
                ScrollView {
                    VStack(alignment: .leading) {
                        // Header with User Info and Icons
                        HStack {
                            Image(systemName: "person.circle")
                                .resizable()
                                .frame(width: 40, height: 40)
                            Text("loveeekiwi") // Replace with actual user data
                                .font(.headline)
                            Spacer()
                            Image(systemName: "star.fill")
                                .foregroundColor(.gray)
                                .font(.caption)
                            Text("5")
                            Spacer()
                            Image(systemName: "ellipsis")
                        }
                        .padding([.horizontal, .top])

                        // Main Image
                        AsyncImage(url: URL(string: listing.photoURLs.first ?? "")) { image in
                            image.resizable()
                                .aspectRatio(contentMode: .fit)
                                .cornerRadius(10)
                        } placeholder: {
                            ProgressView()
                        }
                        .padding(.horizontal)

                        VStack(alignment: .leading, spacing: 8) {
                            Text(listing.title)
                                .font(.title2)
                                .bold()
                            HStack {
                                Text(listing.brand)
                                    .font(.subheadline)
                                    .padding(5)
                                    .background(Color.blue.opacity(0.2))
                                    .cornerRadius(8)
                                Text(listing.condition)
                                    .font(.subheadline)
                                    .padding(5)
                                    .background(Color.gray.opacity(0.2))
                                    .cornerRadius(8)
                                Text("size \(listing.size.rawValue)")
                                    .font(.subheadline)
                                    .padding(5)
                                    .background(Color.gray.opacity(0.2))
                                    .cornerRadius(8)
                            }

                            Text(listing.description)
                                .font(.body)
                                .padding(.top, 5)
                            
                            Spacer()

                            HStack {
                                Text("$\(String(format: "%.2f", listing.price))/day")
                                    .font(.headline)
                                    .foregroundColor(.primary)
                                Spacer()
                                Button(action: {
                                }) {
                                    Text("rent")
                                        .font(.headline)
                                        .padding()
                                        .frame(maxWidth: .infinity)
                                        .background(Color.green.opacity(0.7))
                                        .cornerRadius(10)
                                        .foregroundColor(.white)
                                }
                            }
                        }
                        .padding()
                    }
                }
            } else {
                ProgressView("Loading...")
            }
        }
        .onAppear {
            viewModel.fetchListing(by: listingID)
        }
        .navigationTitle("Listing Details")
        .navigationBarTitleDisplayMode(.inline)
    }
}
