//
//  Listing.swift
//  rently
//
//  Created by Abby Chen on 11/2/24.
//

import Foundation

enum RentalDuration: String {
  case oneWeek = "1 week"
  case twoWeeks = "2 weeks"
  case oneMonth = "1 month"
  case twoMonths = "2 months"
  case threeMonths = "3 months"
  case fourMonths = "4 months"
}

struct Listing: Identifiable {
  var id = UUID()
  var title: String
  var creationTime: Date
  var description: String
  var category: String
  var size: String
  var price: Double
  var color: String
  var condition: String
  var photoURLs: [String]
  var tags: [String]
  var brand: String
  var maxRentalDuration: RentalDuration
  var pickupLocation: String
  var available: Bool
  var rating: Float
}
