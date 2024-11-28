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
  
  // add listing from draft
  func addListingFromDraft(_ draft: ListingDraft, userID: String, completion: @escaping (Result<Void, Error>) -> Void) {
    repository.saveListingFromDraft(draft, userID: userID, completion: completion)
  }

  // upload images via repository
  func uploadImages(_ images: [UIImage], completion: @escaping ([String]) -> Void) {
      repository.uploadImages(images, completion: completion)
  }

  // delete listing
  func deleteListing(_ id: String, completion: @escaping (Result<Void, Error>) -> Void) {
      repository.deleteListing(id, completion: completion)
  }
}
