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
    
    func fetchListings(for userID: String) -> AnyPublisher<[Listing], Error> {
        let url = URL(string: "https://example.com/api/listings?userId=\(userID)")! // Replace with your API URL
        return URLSession.shared.dataTaskPublisher(for: url)
            .map { $0.data }
            .decode(type: [Listing].self, decoder: JSONDecoder())
            .receive(on: DispatchQueue.main)
            .eraseToAnyPublisher()
    }

    // Other CRUD methods (create, update, delete) go here
}
