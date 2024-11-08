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
  
  // add listing
  func addListing(_ listing: Listing) {
    listings.append(listing)
  }
  
  // add images to listing
  func updateListingImages(_ images: [UIImage], forListingAt index: Int) {
    guard listings.indices.contains(index) else { return }
    listings[index].images = images
  }
  
  // edit listing
  
  // delete listing
}
