//
//  ListingDetailViewModel.swift
//  rently
//
//  Created by Sara Riyad on 11/8/24.
//

import Foundation
import SwiftUI
import FirebaseFirestore


class ListingDetailViewModel: ObservableObject {
    @Published var listing: Listing?
    private let db = Firestore.firestore()
    
    func fetchListing(by id: UUID) {
        let docRef = db.collection("listings").document(id.uuidString)
        
        docRef.getDocument { (document, error) in
            if let document = document, document.exists {
                let data = document.data()
                self.listing = Listing(
                    id: id,
                    title: data?["title"] as? String ?? "Untitled",
                    creationTime: Date(),
                    description: data?["description"] as? String ?? "",
                    category: Category(rawValue: data?["category"] as? String ?? "") ?? .womensTops,
                    size: ItemSize(rawValue: data?["size"] as? String ?? "medium") ?? .medium,
                    price: data?["price"] as? Double ?? 0.0,
                    color: ItemColor(rawValue: data?["color"] as? String ?? "blue") ?? .blue,
                    condition: data?["condition"] as? String ?? "",
                    photoURLs: data?["photoURLs"] as? [String] ?? [],
                    tags: [],
                    brand: data?["brand"] as? String ?? "",
                    maxRentalDuration: RentalDuration(rawValue: data?["maxRentalDuration"] as? String ?? "oneMonth") ?? .oneMonth,
                    pickupLocation: PickupLocation(rawValue: data?["pickupLocation"] as? String ?? "uc") ?? .uc,
                    available: data?["available"] as? Bool ?? false,
                    rating: data?["rating"] as? Float ?? 0.0
                )
            } else {
                print("Document does not exist")
            }
        }
    }
}
