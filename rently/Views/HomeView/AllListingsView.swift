//
//  AllListingsView.swift
//  rently
//
//  Created by Grace Liao on 12/12/24.
//

import SwiftUI

struct AllListingsView: View {
    @EnvironmentObject var listingsViewModel: ListingsViewModel
    @EnvironmentObject var userViewModel: UserViewModel

    let columns = [
        GridItem(.flexible()),
        GridItem(.flexible())
    ]

    var body: some View {
        ScrollView {
            LazyVGrid(columns: columns, spacing: 20) {
                ForEach(listingsViewModel.listings) { listing in
                    NavigationLink(destination: ListingDetailView(listingID: listing.id ?? "")
                        .environmentObject(userViewModel)
                        .environmentObject(listingsViewModel)) {
                        CardView(listing: listing)
                    }
                }
            }
            .padding(.horizontal)
        }
        .navigationTitle("All Listings")
        .onAppear {
            print("Displaying all listings: \(listingsViewModel.listings.count)")
        }
    }
}
