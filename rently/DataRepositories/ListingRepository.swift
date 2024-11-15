//
//  ListingRepository.swift
//  rently
//
//  Created by Grace Liao and Sara Riyad on 11/8/24.
//

import FirebaseFirestore
import Combine
import Foundation

class ListingRepository: ObservableObject {
    private let path: String = "Listings" // Firestore collection path
    private let store = Firestore.firestore() // Firestore reference

    @Published var listings: [Listing] = []
    private var cancellables: Set<AnyCancellable> = []

    init() {
        fetchListings()
    }

    // Fetch listings from Firestore
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

    // MARK: CRUD Methods
    func create(_ listing: Listing) {
        do {
            let data = try encodeListing(listing)
            _ = try store.collection(path).addDocument(data: data)
        } catch {
            fatalError("Unable to add listing: \(error.localizedDescription).")
        }
    }

    func update(_ listing: Listing) {
        let listingId = listing.id.uuidString
        
        do {
            let data = try encodeListing(listing)
            try store.collection(path).document(listingId).setData(data)
        } catch {
            fatalError("Unable to update listing: \(error.localizedDescription).")
        }
    }

    func delete(_ listing: Listing) {
        let listingId = listing.id.uuidString
        
        store.collection(path).document(listingId).delete { error in
            if let error = error {
                print("Unable to remove listing: \(error.localizedDescription)")
            }
        }
    }

    // MARK: Helper Methods
    private func encodeListing(_ listing: Listing) throws -> [String: Any] {
        return [
            "id": listing.id.uuidString,
            "title": listing.title,
            "creationTime": listing.creationTime,
            "description": listing.description,
            "category": listing.category.rawValue,
            "size": listing.size.rawValue,
            "price": listing.price,
            "color": listing.color.rawValue,
            "condition": listing.condition,
            "photoURLs": listing.photoURLs,
            "tags": listing.tags.map { $0.rawValue },
            "brand": listing.brand,
            "maxRentalDuration": listing.maxRentalDuration.rawValue,
            "pickupLocation": listing.pickupLocation.rawValue,
            "available": listing.available,
            "rating": listing.rating
        ]
    }
    
    private func decodeListing(from document: DocumentSnapshot) -> Listing? {
        guard let data = document.data() else { return nil }
        
        let id = UUID(uuidString: data["id"] as? String ?? UUID().uuidString) ?? UUID()
        let title = data["title"] as? String ?? "Untitled"
        let creationTime = (data["creationTime"] as? Timestamp)?.dateValue() ?? Date()
        let description = data["description"] as? String ?? ""
        let category = Category(rawValue: data["category"] as? String ?? "") ?? .womensTops
        let size = ItemSize(rawValue: data["size"] as? String ?? "medium") ?? .medium
        let price = data["price"] as? Double ?? 0.0
        let color = ItemColor(rawValue: data["color"] as? String ?? "blue") ?? .blue
        let condition = data["condition"] as? String ?? ""
        let photoURLs = data["photoURLs"] as? [String] ?? []
        let tags = (data["tags"] as? [String] ?? []).compactMap { TagOption(rawValue: $0) }
        let brand = data["brand"] as? String ?? ""
        let maxRentalDuration = RentalDuration(rawValue: data["maxRentalDuration"] as? String ?? "oneMonth") ?? .oneMonth
        let pickupLocation = PickupLocation(rawValue: data["pickupLocation"] as? String ?? "uc") ?? .uc
        let available = data["available"] as? Bool ?? false
        let rating = data["rating"] as? Float ?? 0.0

        return Listing(
            id: id,
            title: title,
            creationTime: creationTime,
            description: description,
            category: category,
            size: size,
            price: price,
            color: color,
            condition: condition,
            photoURLs: photoURLs,
            tags: tags,
            brand: brand,
            maxRentalDuration: maxRentalDuration,
            pickupLocation: pickupLocation,
            available: available,
            rating: rating
        )
    }
}

