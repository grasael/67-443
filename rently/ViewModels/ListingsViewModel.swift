//
//  ListingsViewModel.swift
//  rently
//
//  Created by Abby Chen on 11/2/24.
//

import Foundation
import SwiftUI

class ListingsViewModel: ObservableObject {
    @Published var listings: [Listing] = []

    init() {
        fetchListings() // Load listings when the ViewModel is initialized
    }

    // Add a new listing to Firebase and the local listings array
    func addListing(_ listing: Listing) {
        FirebaseService.shared.saveListing(listing) { result in
            switch result {
            case .success:
                DispatchQueue.main.async {
                    self.listings.append(listing)
                }
                print("Listing added successfully.")
            case .failure(let error):
                print("Failed to save listing: \(error.localizedDescription)")
            }
        }
    }

    // Fetch listings from Firebase
    func fetchListings() {
        FirebaseService.shared.fetchListings { result in
            switch result {
            case .success(let fetchedListings):
                DispatchQueue.main.async {
                    self.listings = fetchedListings
                }
                print("Fetched listings successfully.")
            case .failure(let error):
                print("Failed to fetch listings: \(error.localizedDescription)")
            }
        }
    }

    // Edit a listing in Firebase and update the local listings array
    func editListing(_ listing: Listing) {
        if let index = listings.firstIndex(where: { $0.id == listing.id }) {
            FirebaseService.shared.saveListing(listing) { result in
                switch result {
                case .success:
                    DispatchQueue.main.async {
                        self.listings[index] = listing
                    }
                    print("Listing updated successfully.")
                case .failure(let error):
                    print("Failed to update listing: \(error.localizedDescription)")
                }
            }
        } else {
            print("Listing not found for editing.")
        }
    }

    // Delete a listing from Firebase and remove it from the local listings array
    func deleteListing(_ listing: Listing) {
        guard let listingID = listing.id else {
            print("Listing ID is nil. Cannot delete.")
            return
        }
        FirebaseService.shared.deleteListing(listingID) { result in
            switch result {
            case .success:
                DispatchQueue.main.async {
                    self.listings.removeAll { $0.id == listingID }
                }
                print("Listing deleted successfully.")
            case .failure(let error):
                print("Failed to delete listing: \(error.localizedDescription)")
            }
        }
    }
}
