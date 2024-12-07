//
//  ListingsProfileView.swift
//  rently
//
//  Created by Grace Liao on 11/8/24.
//
// These are just all the ones inside of Firebase for testing purposes only... need to filter for a specific user later
import SwiftUI

struct ListingsProfileView: View {
    @EnvironmentObject var userViewModel: UserViewModel
    @EnvironmentObject var listingsViewModel: ListingsViewModel

    let columns = [
        GridItem(.flexible()),
        GridItem(.flexible())
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
                .padding(.horizontal)
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
