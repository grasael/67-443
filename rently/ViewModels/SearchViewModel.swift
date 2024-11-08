//
//  SearchViewModel.swift
//  rently
//
//  Created by Sara Riyad on 11/2/24.
//

import SwiftUI
import FirebaseFirestore

class SearchViewModel: ObservableObject {
    @Published var listings = [Listing]()
    @Published var users = [User]()
    private let db = Firestore.firestore()
    
    func fetchListings() {
        db.collection("listings").getDocuments { snapshot, error in
            if let error = error {
                print("Error fetching listings: \(error)")
                return
            }
            
            self.listings = snapshot?.documents.map { document in
                let data = document.data()
                let uuid = UUID(uuidString: document.documentID) ?? UUID()
                
                return Listing(
                    id: uuid,
                    title: data["title"] as? String ?? "Untitled",
                    creationTime: Date(),
                    description: data["description"] as? String ?? "",
                    category: Category(rawValue: data["category"] as? String ?? "") ?? .womensTops,
                    size: ItemSize(rawValue: data["size"] as? String ?? "medium") ?? .medium,
                    price: data["price"] as? Double ?? 0.0,
                    color: ItemColor(rawValue: data["color"] as? String ?? "blue") ?? .blue,
                    condition: data["condition"] as? String ?? "",
                    photoURLs: data["photoURLs"] as? [String] ?? [],
                    tags: [],
                    brand: data["brand"] as? String ?? "",
                    maxRentalDuration: RentalDuration(rawValue: data["maxRentalDuration"] as? String ?? "oneMonth") ?? .oneMonth,
                    pickupLocation: PickupLocation(rawValue: data["pickupLocation"] as? String ?? "uc") ?? .uc,
                    available: data["available"] as? Bool ?? false,
                    rating: data["rating"] as? Float ?? 0.0
                )
            } ?? []
        }
    }

    func fetchUsers() {
        db.collection("users").getDocuments { snapshot, error in
            if let error = error {
                print("Error fetching users: \(error)")
                return
            }
            
            self.users = snapshot?.documents.compactMap { document in
                try? document.data(as: User.self)
            } ?? []
        }
    }

    func performSearch(query: String) {
        let lowercasedQuery = query.lowercased()
        
        fetchListings()  // Re-fetch to get the initial data
        fetchUsers()
        
        self.listings = listings.filter { listing in
            listing.title.lowercased().contains(lowercasedQuery) ||
            listing.category.rawValue.lowercased().contains(lowercasedQuery) ||
            listing.description.lowercased().contains(lowercasedQuery)
        }

        self.users = users.filter { user in
            user.username.lowercased().contains(lowercasedQuery) ||
            user.firstName.lowercased().contains(lowercasedQuery) ||
            user.lastName.lowercased().contains(lowercasedQuery) ||
            (user.firstName.lowercased() + user.lastName.lowercased()).contains(lowercasedQuery)
        }
    }
}

