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
    private let db = Firestore.firestore()

    func fetchListings() {
        db.collection("listings").getDocuments { snapshot, error in
            if let error = error {
                print("Error fetching listings: \(error)")
                return
            }
            
            self.listings = snapshot?.documents.map { document in
                let data = document.data()
                
                guard let idString = document.documentID as String?,
                      let uuid = UUID(uuidString: idString) else {
                    return Listing(id: UUID(), title: "Untitled", creationTime: Date(), description: "", category: .womensTops, size: .medium, price: 0.0, color: .blue, condition: "", photoURLs: [], tags: [], brand: "", maxRentalDuration: .oneMonth, pickupLocation: .uc, available: false, rating: 0.0)
                }
                
                return Listing(
                    id: uuid,
                    title: data["title"] as? String ?? "Untitled",
                    creationTime: Date(), // Replace with actual timestamp if needed
                    description: data["description"] as? String ?? "",
                    category: Category(rawValue: data["category"] as? String ?? "") ?? .womensTops,
                    size: ItemSize(rawValue: data["size"] as? String ?? "medium") ?? .medium,
                    price: data["price"] as? Double ?? 0.0,
                    color: ItemColor(rawValue: data["color"] as? String ?? "blue") ?? .blue,
                    condition: data["condition"] as? String ?? "",
                    photoURLs: data["photoURLs"] as? [String] ?? [],
                    tags: [], // Use actual tags if available
                    brand: data["brand"] as? String ?? "",
                    maxRentalDuration: RentalDuration(rawValue: data["maxRentalDuration"] as? String ?? "oneMonth") ?? .oneMonth,
                    pickupLocation: PickupLocation(rawValue: data["pickupLocation"] as? String ?? "uc") ?? .uc,
                    available: data["available"] as? Bool ?? false,
                    rating: data["rating"] as? Float ?? 0.0
                )
            } ?? []
        }
    }
}
