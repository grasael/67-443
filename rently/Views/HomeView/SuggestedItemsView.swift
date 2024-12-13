//
//  SuggestedItemsView.swift
//  rently
//
//  Created by Tishyaa Chaudhry on 11/2/24.
//

import Foundation
import SwiftUI

struct SuggestedItemsView: View {
    @EnvironmentObject var userViewModel: UserViewModel
    @EnvironmentObject var listingsViewModel: ListingsViewModel // Use the shared instance

    var body: some View {
        VStack(alignment: .leading, spacing: 10) {
            HStack {
                Text("we thought you would like")
                    .font(.headline)
                Spacer()
                NavigationLink(destination: AllListingsView()
                    .environmentObject(userViewModel)
                    .environmentObject(listingsViewModel)) {
                    Text("see all")
                        .foregroundColor(Color("Red"))
                }
            }
            .padding(.bottom, 10)

            ScrollView(.horizontal, showsIndicators: false) {
                HStack(spacing: 15) {
                    ForEach(listingsViewModel.listings.prefix(5)) { listing in
                        NavigationLink(destination: ListingDetailView(listingID: listing.id ?? "")
                            .environmentObject(userViewModel)
                            .environmentObject(listingsViewModel)) {
                            VStack {
                                // Image carousel for the listing
                                if let imageUrl = URL(string: listing.photoURLs.first ?? "sampleItemImage") {
                                    AsyncImage(url: imageUrl) { phase in
                                        switch phase {
                                        case .empty:
                                            ProgressView()
                                                .frame(width: 80, height: 80)
                                        case .success(let image):
                                            image
                                                .resizable()
                                                .scaledToFill()
                                                .frame(width: 80, height: 80)
                                                .clipped()
                                                .cornerRadius(8)
                                        case .failure:
                                            Image("sampleItemImage")
                                                .resizable()
                                                .frame(width: 80, height: 80)
                                                .cornerRadius(8)
                                        @unknown default:
                                            EmptyView()
                                        }
                                    }
                                }
                                Text(listing.title)
                                .foregroundColor(.black)
                                .font(.system(size: 13))
                                Text("$\(listing.price, specifier: "%.2f")/day")
                                .foregroundColor(.black)
                                .font(.system(size: 13))
                                Text("size \(listing.size.rawValue)")
                                .foregroundColor(.black)
                                .font(.system(size: 13))
                            }
                        }
                    }
                }
            }
            .onAppear {
                // Fetch listings using user preferences
                let userPreferences = userViewModel.user.styleChoices + userViewModel.user.events
                listingsViewModel.fetchListings(for: userPreferences) // Use the shared instance
            }
        }
    }
}
