//
//  Rental.swift
//  rently
//
//  Created by Tishyaa Chaudhry on 11/4/24.
//

// MARK: RentalModel.swift
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
  
    var daysUntilPickup: Int {
        let currentDate = Calendar.current.startOfDay(for: Date())
        let adjustedStartDate = Calendar.current.startOfDay(for: startDate)
        if adjustedStartDate > currentDate {
            return Calendar.current.dateComponents([.day], from: currentDate, to: adjustedStartDate).day ?? 0
        } else if endDate >= currentDate && adjustedStartDate <= currentDate {
            return Calendar.current.dateComponents([.day], from: currentDate, to: Calendar.current.startOfDay(for: endDate)).day ?? 0
        } else {
            return 0
        }
    }

  
    var rentalStatusText: String {
        if startDate > Date() {
            return "\(daysUntilPickup) days until pickup"
        } else if endDate >= Date() && startDate <= Date() {
            return "\(daysUntilPickup) days until dropoff"
        } else {
            return "Rental has ended"
        }
    }
      
    func getListing(from listings: [Listing]) -> Listing? {
        return listings.first { $0.id == self.listingID }
    }
  
    var rentalDurationInDays: Int {
        let calendar = Calendar.current
        return calendar.dateComponents([.day], from: startDate, to: endDate).day ?? 0
    }

    func calculateTotalCost(for listing: Listing?) -> Double {
        guard let pricePerDay = listing?.price else { return 0.0 }
        return Double(rentalDurationInDays) * pricePerDay
    }
}
