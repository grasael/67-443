//
//  ListingRepository.swift
//  rently
//
//  Created by Grace Liao on 11/8/24.
//

import FirebaseFirestore
import Combine

class ListingRepository: ObservableObject {
    private let path: String = "Listings" // Firestore collection path
    private let store = Firestore.firestore() // Firestore reference

    @Published var listings: [Listing] = []
    private var cancellables: Set<AnyCancellable> = []

    init() {
        fetchListings()
    }

    func fetchListings() {
        store.collection(path)
            .addSnapshotListener { querySnapshot, error in
                if let error = error {
                    print("Error fetching listings: \(error.localizedDescription)")
                    return
                }
                
                self.listings = querySnapshot?.documents.compactMap { document in
                    try? document.data(as: Listing.self)
                } ?? []
            }
    }

    // Other CRUD methods (create, update, delete) go here
}
