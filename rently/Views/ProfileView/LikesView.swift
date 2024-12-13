//
//  LikesView.swift
//  rently
//
//  Created by Grace Liao on 11/3/24.
// WILL BE IMPLEMENTED IN V2

import SwiftUI

struct LikesView: View {
    @EnvironmentObject var userViewModel: UserViewModel
    @EnvironmentObject var listingsViewModel: ListingsViewModel

    let columns = [
        GridItem(.flexible()),
        GridItem(.flexible())
    ]

    var body: some View {
        NavigationView {
            ScrollView {
                if userViewModel.user.likedItems.isEmpty {
                    Text("you haven't liked any items yet.")
                        .font(.subheadline)
                        .foregroundColor(.gray)
                        .padding()
                } else {
                    LazyVGrid(columns: columns, spacing: 20) {
                        ForEach(userViewModel.user.likedItems, id: \.self) { likedListingID in
                            if let listing = listingsViewModel.listings.first(where: { $0.id == likedListingID }) {
                                NavigationLink(destination: ListingView(listing: listing)
                                                .environmentObject(userViewModel)) {
                                    CardView(listing: listing)
                                }
                            }
                        }
                    }
                    .padding(.horizontal)
                }
            }
            .navigationTitle("")
            .onAppear {
                // Fetch liked listings if needed
                listingsViewModel.fetchListings() // Assuming this fetches all listings
            }
        }
    }
}
