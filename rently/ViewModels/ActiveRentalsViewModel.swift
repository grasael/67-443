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
  
      
  //TODO: refactor into a seperate ViewModel maybe
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

}
