//
//  RentalViewModel.swift
//  rently
//
//  Created by Tishyaa Chaudhry on 11/4/24.
//

import Foundation
import FirebaseFirestore

class ActiveRentalsViewModel: ObservableObject {
    @Published var rentals = [Rental]()
    @Published var isLoading = false
    @Published var renter: User?
    @Published var listing: Listing?
    
    private var db = Firestore.firestore()
    private let renteeID = "0" // Replace with actual hardcoded ID
    
    func fetchActiveRentals() {
        isLoading = true
        db.collection("Rentals")
            .whereField("renteeID", isEqualTo: renteeID)
            .addSnapshotListener { (querySnapshot, error) in
                self.isLoading = false
                
                if let error = error {
                    print("Error fetching rentals: \(error.localizedDescription)")
                    return
                }
                
                guard let documents = querySnapshot?.documents else {
                    print("No rentals found.")
                    return
                }
                
                // Map documents to Rental objects and filter by isActive
                self.rentals = documents.compactMap { document in
                    do {
                        let rental = try document.data(as: Rental.self)
                        return rental.isActiveOrUpcoming ? rental : nil
                    } catch {
                        print("Error decoding rental: \(error.localizedDescription)")
                        return nil
                    }
                }
                
                print("Successfully fetched \(self.rentals.count) active rentals.")
            }
    }
  
      
  func loadRenterDetails(rental: Rental) {
         print("Loading renter details for rental with renter ID: \(rental.renterID)")
         fetchUser(byID: rental.renterID) { [weak self] user in
             DispatchQueue.main.async {
                 self?.renter = user
                 if let user = user {
                     print("Successfully set renter: \(user.username)")
                 } else {
                     print("Failed to set renter - user is nil")
                 }
             }
         }
     }
     
     func fetchUser(byID userID: String, completion: @escaping (User?) -> Void) {
         db.collection("Users").document(userID).getDocument { snapshot, error in
             if let error = error {
                 print("Error fetching user: \(error.localizedDescription)")
                 completion(nil)
                 return
             }
             
             guard let snapshot = snapshot else {
                 print("No snapshot received for userID: \(userID)")
                 completion(nil)
                 return
             }
             
             print("Fetched snapshot for userID \(userID): \(snapshot.data() ?? [:])")

             do {
                 let user = try snapshot.data(as: User.self)
                 print("Successfully converted snapshot to User: \(user)")
                 completion(user)
             } catch {
                 print("Error converting snapshot to User: \(error.localizedDescription)")
                 completion(nil)
             }
         }
     }



func loadListingDetails(rental: Rental) {
        print("Loading listing details for rental with listing ID: \(rental.listingID)")
        fetchListing(byID: rental.listingID) { [weak self] listing in
            DispatchQueue.main.async {
                self?.listing = listing
                if let listing = listing {
                    print("Successfully set listing: \(listing.title)")
                } else {
                    print("Failed to set listing - listing is nil")
                }
            }
        }
    }
    
    func fetchListing(byID listingID: String, completion: @escaping (Listing?) -> Void) {
        db.collection("Listings").document(listingID).getDocument { snapshot, error in
            if let error = error {
                print("Error fetching listing: \(error.localizedDescription)")
                completion(nil)
                return
            }
            
            guard let snapshot = snapshot else {
                print("No snapshot received for listingID: \(listingID)")
                completion(nil)
                return
            }
            
            print("Fetched snapshot for listingID \(listingID): \(snapshot.data() ?? [:])")

            do {
                let listing = try snapshot.data(as: Listing.self)
                print("Successfully converted snapshot to Listing: \(listing)")
                completion(listing)
            } catch {
                print("Error converting snapshot to Listing: \(error.localizedDescription)")
                completion(nil)
            }
        }
    }
}
