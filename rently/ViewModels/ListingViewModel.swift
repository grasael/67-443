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
          fetchListings()
      }
  
  // add listing
  func addListing() {
    
  }
  func fetchListings() {
          print("Fetching listings from Firestore...")  // Debug: Function called

          db.collection("Listings")
              .getDocuments { snapshot, error in
                  if let error = error {
                      print("Error fetching listings: \(error)")  // Debug: Error case
                      return
                  }

                  guard let documents = snapshot?.documents else {
                      print("No documents found in the listings collection.")  // Debug: No documents case
                      return
                  }

                  print("Documents fetched: \(documents.count)")  // Debug: Documents count

                  self.listings = documents.compactMap { document in
                      do {
                          let listing = try document.data(as: Listing.self)
//                          print("Fetched listing: \(listing.title), Price: \(listing.price)")  // Debug: Each document
                          return listing
                      } catch {
                          print("Error decoding document: \(error)")  // Debug: Decoding error
                          return nil
                      }
                  }

                  print("Total listings after decoding: \(self.listings.count)")  // Debug: Decoded items count
              }
      
      }
  
  // edit listing
  
  // delete listing
}
