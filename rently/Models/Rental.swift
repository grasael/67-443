//
//  Rental.swift
//  rently
//
//  Created by Tishyaa Chaudhry on 11/4/24.
//

// RentalModel.swift
import Foundation
import FirebaseFirestore

struct Rental: Codable, Identifiable {
    @DocumentID var id: String?
    var renteeID: String // Use hardcoded rentee ID in ViewModel
    var renterID: String
    var startDate: Date
    var endDate: Date
    var pickupLocation: String
    var listingID: String
    var message: String
    var status: String // e.g., "active"
  
    var isActiveOrUpcoming: Bool { // might remove the status since it is redundant if we dont allow cancellations
          let currentDate = Date()
          return currentDate <= endDate
      }
}


