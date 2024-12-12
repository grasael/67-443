//
//  ListingsProfileView.swift
//  rently
//
//  Created by Grace Liao on 11/8/24.
//

import SwiftUI

struct ListingsProfileView: View {
    @EnvironmentObject var userViewModel: UserViewModel
    @EnvironmentObject var listingsViewModel: ListingsViewModel

    let columns = [
      GridItem(.flexible(), spacing: 16),
      GridItem(.flexible(), spacing: 16)
    ]

    var body: some View {
        NavigationView {
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
                .padding(.horizontal, 16)
            }
            .onAppear {
              // fetch listings specific to the current user
              if let userID = userViewModel.user.id {
                listingsViewModel.fetchListings(for: userID)
              }
            }
        }
        .navigationTitle("Profile")
    }
}
