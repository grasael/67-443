//
//  ListingsViewModel.swift
//  rently
//
//  Created by Abby Chen on 11/2/24.
//

import Foundation
import SwiftUI
import Combine

class ListingsViewModel: ObservableObject {
  @Published var listings: [Listing] = []
  private var repository = ListingRepository()
  private var cancellables: Set<AnyCancellable> = []

  var listingsCount: Int {
    listings.count
  }

  init() {
    repository.$listings
      .assign(to: \.listings, on: self)
      .store(in: &cancellables)
  }
  
  // fetch listings
  func fetchListings() {
    repository.fetchListings()
  }
  
  // fetch listings for a specific user
  func fetchListings(for userID: String) {
      repository.fetchListings(for: userID)
  }
    
  // fetch listings based on user's preferences
    func fetchListings(for preferences: [String]) {
        // Debugging: Print user preferences
        print("🔍 User Preferences: \(preferences)")

        // Map user preferences to tags as plain strings
        let matchedTags = mapPreferencesToTags(preferences: preferences)
        print("🔗 Mapped Tags: \(matchedTags)")

        // Fetch listings from the repository based on matched tags
        repository.fetchListings(for: matchedTags)
    }

  // Filter listings for a specific user
  func listings(for userID: String) -> [Listing] {
      return listings.filter { $0.userID == userID }
  }

  // Count listings for a specific user
  func listingsCount(for userID: String) -> Int {
      return listings(for: userID).count
  }
  
  // add listing from draft
  func addListingFromDraft(_ draft: ListingDraft, userID: String, completion: @escaping (Result<Void, Error>) -> Void) {
    repository.saveListingFromDraft(draft, userID: userID, completion: completion)
  }
  
  // edit existing listing
  func editListing(_ listingID: String, draft: ListingDraft, userID: String, completion: @escaping (Result<Void, Error>) -> Void) {
    repository.updateListing(listingID: listingID, with: draft, userID: userID, completion: completion)
  }

  // upload images via repository
  func uploadImages(_ images: [UIImage], completion: @escaping ([String]) -> Void) {
      repository.uploadImages(images, completion: completion)
  }

  // delete listing
  func deleteListing(_ id: String, completion: @escaping (Result<Void, Error>) -> Void) {
    repository.deleteListing(id, completion: completion)
  }
    
    private func mapPreferencesToTags(preferences: [String]) -> [String] {
        // Define the mapping between user preferences and tag strings
        let mapping: [String: [String]] = [
            "vintage": ["vintage"],
            "sportswear": ["sportswear"],
            "edgy": ["edgy"],
            "preppy": ["classy", "casual"],
            "boho chic": ["casual", "vintage"],
            "grunge": ["edgy", "streetwear"],
            "classy": ["classy"],
            "casual": ["casual"],
            "streetwear": ["streetwear"],
            "y2k": ["y2k", "trendy"],
            "trendy": ["y2k", "classy"],
            
            "formal events": ["formal"],
            "business casual": ["business"],
            "party": ["party"],
            "athleisure": ["sportswear", "casual"],
            "vacation": ["casual", "streetwear"],
            "rave": ["party", "y2k"],
            "concert": ["concert", "streetwear"],
            "costume": ["costume"],
            "graduation": ["graduation"],
            "job interview": ["formal", "business"]
        ]

        var tags: [String] = []
        for preference in preferences {
            if let matchedTags = mapping[preference] {
                print("✅ Preference '\(preference)' mapped to tags: \(matchedTags)")
                tags.append(contentsOf: matchedTags)
            } else {
                print("⚠️ Preference '\(preference)' not found in mapping")
            }
        }

        let uniqueTags = Array(Set(tags)) // Remove duplicates
        print("📋 Unique Tags: \(uniqueTags)")
        return uniqueTags
    }
}
