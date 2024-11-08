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
                        Text(listing.title)
                            .font(.title)
                            .bold()
                            .padding(.horizontal)

                        AsyncImage(url: URL(string: listing.photoURLs.first ?? "")) { image in
                            image.resizable()
                                .aspectRatio(contentMode: .fit)
                                .cornerRadius(10)
                        } placeholder: {
                            ProgressView()
                        }
                        .padding()

                        Text(listing.description)
                            .padding(.horizontal)
                        
                        Text("$\(String(format: "%.2f", listing.price))/day")
                            .font(.headline)
                            .padding(.horizontal)
                        
                        // Additional listing details...
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
