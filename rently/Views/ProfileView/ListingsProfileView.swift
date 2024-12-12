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

struct MockData {
    static let mockListings: [Listing] = [
        Listing(
            id: "1",
            title: "Meshki midi dress",
            creationTime: Date(),
            description: "A beautiful midi dress, perfect for formal events.",
            category: .dresses,
            userID: "user123",
            size: .small,
            price: 5.00,
            color: .blue,
            condition: .veryGood,
            photoURLs: ["https://firebasestorage.googleapis.com:443/v0/b/rently-439319.firebasestorage.app/o/images%2F563EB8A0-77D1-4ECC-8015-6D8ABBDAD235.jpg?alt=media&token=d2d5c6c8-0a6c-4123-a949-8e642e2c6d78"],
            tags: [.formal],
            brand: "Meshki",
            maxRentalDuration: .oneWeek,
            pickupLocations: [.uc],
            available: true
        ),
        Listing(
            id: "2",
            title: "Aritzia dress pants",
            creationTime: Date(),
            description: "Stylish and comfortable pants for business casual looks.",
            category: .womensBottoms,
            userID: "user123",
            size: .medium,
            price: 7.00,
            color: .cream,
            condition: .good,
            photoURLs: ["https://firebasestorage.googleapis.com/v0/b/rently-439319.firebasestorage.app/o/e661edd139399e-QY407355095_grande.webp.jpeg?alt=media&token=1fdcb90c-da8c-4b1c-aaf9-ae3faa92d26f"],
            tags: [.business, .classy],
            brand: "Aritzia",
            maxRentalDuration: .twoWeeks,
            pickupLocations: [.tepper],
            available: true
        )
    ]

    static let mockUser = User(
        id: "user123",
        firstName: "Amelia",
        lastName: "Bose",
        username: "amelia123",
        pronouns: "she/her",
        email: "amelia@example.com",
        password: "password123",
        university: "Carnegie Mellon University",
        rating: 5.0,
        listings: [],
        likedItems: [],
        styleChoices: ["formal", "casual"],
        events: ["party", "conference"],
        followers: ["user1", "user2"],
        following: ["user3", "user4"],
        renting: ["item1", "item2"],
        myItems: ["item3", "item4"]
    )
}


struct ListingsProfileView_Previews: PreviewProvider {
    static var previews: some View {
        let mockListingsViewModel = ListingsViewModel()
        let mockUserViewModel = UserViewModel(user: MockData.mockUser)

        // Inject mock listings into the view model
        mockListingsViewModel.listings = MockData.mockListings

        return ListingsProfileView()
            .environmentObject(mockUserViewModel)
            .environmentObject(mockListingsViewModel)
    }
}

