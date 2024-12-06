//
//  ListingsProfileView.swift
//  rently
//
//  Created by Grace Liao on 11/8/24.
//
// These are just all the ones inside of Firebase for testing purposes only... need to filter for a specific user later
import SwiftUI

struct ListingsProfileView: View {
    @StateObject private var viewModel = ListingsViewModel()

    let columns = [
        GridItem(.flexible()),
        GridItem(.flexible())
    ]

    var body: some View {
        NavigationView {
            ScrollView {
                LazyVGrid(columns: columns, spacing: 20) {
                    ForEach(viewModel.listings) { listing in
                        NavigationLink(destination: ListingDetailView(listingID: listing.id ?? "")) {
                            CardView(listing: listing)
                        }

                    }
                }
                .padding(.horizontal)
            }
            .onAppear {
                viewModel.fetchListings()
            }
        }
        .navigationTitle("Profile")
    }
}
