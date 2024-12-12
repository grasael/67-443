//
//  LikesView.swift
//  rently
//
//  Created by Grace Liao on 11/3/24.
// WILL BE IMPLEMENTED IN V2

import SwiftUI

struct LikesView: View {
    @EnvironmentObject var listingsViewModel: ListingsViewModel

    let columns = [
        GridItem(.flexible()),
        GridItem(.flexible())
    ]

    var body: some View {
        NavigationView {
            ScrollView {
                if let likedItems = UserManager.shared.user?.likedItems, likedItems.isEmpty {
                    Text("You haven't liked any items yet.")
                        .font(.subheadline)
                        .foregroundColor(.gray)
                        .padding()
                } else {
                    LazyVGrid(columns: columns, spacing: 20) {
                        ForEach(UserManager.shared.user?.likedItems ?? [], id: \.self) { likedListingID in
                            if let listing = listingsViewModel.listings.first(where: { $0.id == likedListingID }) {
                              NavigationLink(destination: ListingDetailView(listingID: listing.id ?? "")) {
                                    CardView(listing: listing)
                                }
                            }
                        }
                    }
                    .padding(.horizontal)
                }
            }
            .navigationTitle("Likes")
            .onAppear {
                // Ensure listings are up to date
                listingsViewModel.fetchListings() // Assuming this fetches all listings
            }
        }
    }
}
