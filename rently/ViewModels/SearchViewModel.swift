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
      db.collection("Listings").getDocuments { snapshot, error in
          if let error = error {
              print("Error fetching listings: \(error)")
              return
          }
          
          self.listings = snapshot?.documents.map { document in
              let data = document.data()
              let uuid = UUID(uuidString: document.documentID) ?? UUID()

              // Updated to reflect the new model
              return Listing(
                  id: document.documentID,
                  title: data["title"] as? String ?? "Untitled",
                  creationTime: data["creationTime"] as? Date ?? Date(),
                  description: data["description"] as? String ?? "",
                  category: Category(rawValue: data["category"] as? String ?? "") ?? .womensTops,
                  userID: data["userID"] as? String ?? "",
                  size: ItemSize(rawValue: data["size"] as? String ?? "medium") ?? .medium,
                  price: data["price"] as? Double ?? 0.0,
                  color: ItemColor(rawValue: data["color"] as? String ?? "blue") ?? .blue,
                  condition: Condition(rawValue: data["condition"] as? String ?? "") ?? .good,
                  photoURLs: data["photoURLs"] as? [String] ?? [],
                  tags: (data["tags"] as? [String])?.compactMap { TagOption(rawValue: $0) } ?? [],
                  brand: data["brand"] as? String ?? "",
                  maxRentalDuration: RentalDuration(rawValue: data["maxRentalDuration"] as? String ?? "oneMonth") ?? .oneMonth,
                  pickupLocations: (data["pickupLocations"] as? [String])?.compactMap { PickupLocation(rawValue: $0) } ?? [],
                  available: data["available"] as? Bool ?? false
              )
          } ?? []
      }
  
  }
  func fetchUsers() {
      db.collection("Users").getDocuments { snapshot, error in
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

