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
    
  
  func fetchListing(by id: String) {
    
      let docRef = db.collection("Listings").document(id)
      
      docRef.getDocument { (document, error) in
          if let document = document, document.exists {
              let data = document.data()

              // Updated to reflect the new model
              self.listing = Listing(
                  id: document.documentID,
                  title: data?["title"] as? String ?? "Untitled",
                  creationTime: data?["creationTime"] as? Date ?? Date(),
                  description: data?["description"] as? String ?? "",
                  category: Category(rawValue: data?["category"] as? String ?? "") ?? .womensTops,
                  userID: data?["userID"] as? String ?? "",
                  size: ItemSize(rawValue: data?["size"] as? String ?? "medium") ?? .medium,
                  price: data?["price"] as? Double ?? 0.0,
                  color: ItemColor(rawValue: data?["color"] as? String ?? "blue") ?? .blue,
                  condition: Condition(rawValue: data?["condition"] as? String ?? "") ?? .good,
                  photoURLs: data?["photoURLs"] as? [String] ?? [],
                  tags: (data?["tags"] as? [String])?.compactMap { TagOption(rawValue: $0) } ?? [],
                  brand: data?["brand"] as? String ?? "",
                  maxRentalDuration: RentalDuration(rawValue: data?["maxRentalDuration"] as? String ?? "oneMonth") ?? .oneMonth,
                  pickupLocations: (data?["pickupLocations"] as? [String])?.compactMap { PickupLocation(rawValue: $0) } ?? [],
                  available: data?["available"] as? Bool ?? false
              )
          } else {
              print("Document does not exist")
          }
      }
  }
  
  func fetchListingObj(by id: String, completion: @escaping (Listing?) -> Void) {
      let docRef = db.collection("Listings").document(id)
      
      docRef.getDocument { (document, error) in
          if let document = document, document.exists {
              let data = document.data()
              let listing = Listing(
                  id: document.documentID,
                  title: data?["title"] as? String ?? "Untitled",
                  creationTime: (data?["creationTime"] as? Timestamp)?.dateValue() ?? Date(),
                  description: data?["description"] as? String ?? "",
                  category: Category(rawValue: data?["category"] as? String ?? "") ?? .womensTops,
                  userID: data?["userID"] as? String ?? "",
                  size: ItemSize(rawValue: data?["size"] as? String ?? "medium") ?? .medium,
                  price: data?["price"] as? Double ?? 0.0,
                  color: ItemColor(rawValue: data?["color"] as? String ?? "blue") ?? .blue,
                  condition: Condition(rawValue: data?["condition"] as? String ?? "") ?? .good,
                  photoURLs: data?["photoURLs"] as? [String] ?? [],
                  tags: (data?["tags"] as? [String])?.compactMap { TagOption(rawValue: $0) } ?? [],
                  brand: data?["brand"] as? String ?? "",
                  maxRentalDuration: RentalDuration(rawValue: data?["maxRentalDuration"] as? String ?? "oneMonth") ?? .oneMonth,
                  pickupLocations: (data?["pickupLocations"] as? [String])?.compactMap { PickupLocation(rawValue: $0) } ?? [],
                  available: data?["available"] as? Bool ?? false
              )
              completion(listing)
          } else {
              print("Document does not exist")
              completion(nil)
          }
      }
  }


}
