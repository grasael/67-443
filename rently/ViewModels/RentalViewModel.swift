//
//  RentalViewModel.swift
//  rently
//
//  Created by Tishyaa Chaudhry on 12/4/24.
//

import Foundation
import FirebaseFirestore

class RentalViewModel: ObservableObject {
    private let db = Firestore.firestore()
    
    // Direct reference to the shared UserManager instance
    private let userManager = UserManager.shared
    
    func fetchUserEmail(for userID: String, completion: @escaping (String?) -> Void) {
        let db = Firestore.firestore()
        db.collection("Users").document(userID).getDocument { document, error in
            if let document = document, document.exists, let data = document.data() {
                let email = data["email"] as? String
                completion(email)
            } else {
                print("Error fetching user email: \(error?.localizedDescription ?? "Unknown error")")
                completion(nil)
            }
        }
    }
    
  func createRental(listing: Listing, pickupDate: Date, dropoffDate: Date, location: String) {
      // Get the renteeID from the shared userManager
      guard let renteeID = userManager.user?.id else {
          print("Error: No user found.")
          return
      }
      
      let rentalID = db.collection("Rentals").document().documentID // Generate the rental document ID
      
      let newRental = Rental(
          renteeID: renteeID,
          renterID: listing.userID,
          startDate: pickupDate,
          endDate: dropoffDate,
          pickupLocation: location,
          listingID: listing.id ?? "",
          message: "",
          status: ""
      )
      
      do {
          // Save the rental to the Rentals collection
          try db.collection("Rentals").document(rentalID).setData(from: newRental) { [weak self] error in
              if let error = error {
                  print("Error saving rental: \(error.localizedDescription)")
                  return
              }
              print("Rental request sent successfully.")
              
              // Update the rentee's renting list
              self?.updateUserRentingList(userID: renteeID, rentalID: rentalID)
              
              // Update the renter's myItems list
              self?.updateUserMyItemsList(userID: listing.userID, rentalID: rentalID)
          }
      } catch {
          print("Error encoding rental: \(error.localizedDescription)")
      }
  }

  // MARK: - Helper Methods

  private func updateUserRentingList(userID: String, rentalID: String) {
      let userRef = db.collection("Users").document(userID)
      userRef.updateData([
          "renting": FieldValue.arrayUnion([rentalID])
      ]) { error in
          if let error = error {
              print("Error updating rentee renting list: \(error.localizedDescription)")
          } else {
              print("Rentee renting list updated successfully.")
          }
      }
  }

  private func updateUserMyItemsList(userID: String, rentalID: String) {
      let userRef = db.collection("Users").document(userID)
      userRef.updateData([
          "myItems": FieldValue.arrayUnion([rentalID])
      ]) { error in
          if let error = error {
              print("Error updating renter myItems list: \(error.localizedDescription)")
          } else {
              print("Renter myItems list updated successfully.")
          }
      }
  }

    
    func calculateTotalCost(for listing: Listing, from startDate: Date, to endDate: Date) -> String {
        let totalDays = Calendar.current.dateComponents([.day], from: startDate, to: endDate).day ?? 1
        let total = Double(totalDays) * listing.price
        return String(format: "%.2f", total)
    }
}
