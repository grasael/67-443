//
//  ListingRepository.swift
//  rently
//
//  Created by Grace Liao on 11/8/24.
//

import FirebaseFirestore
import Combine
import FirebaseStorage
import UIKit

class ListingRepository: ObservableObject {
    private let path: String = "Listings"
    private let store = Firestore.firestore()
    private let storage = Storage.storage()

    @Published var listings: [Listing] = []
    private var cancellables: Set<AnyCancellable> = []

    init() {
        fetchListings()
    }

    // fetch listings
    func fetchListings() {
        store.collection(path)
            .addSnapshotListener { querySnapshot, error in
                if let error = error {
                    print("Error fetching listings: \(error.localizedDescription)")
                    return
                }

                self.listings = querySnapshot?.documents.compactMap { document in
                    try? document.data(as: Listing.self)
                } ?? []
            }
    }
    
    // fetch listings based on tags/prefs
    func fetchListings(for tags: [String]) {
        print("Fetching listings with tags: \(tags)")
        store.collection(path)
            .whereField("tags", arrayContainsAny: tags) // Query for listings with matching tags
            .getDocuments { querySnapshot, error in
                if let error = error {
                    print("Error fetching listings: \(error.localizedDescription)")
                    return
                }

                self.listings = querySnapshot?.documents.compactMap { document in
                    try? document.data(as: Listing.self)
                } ?? []

                print("Fetched \(self.listings.count) filtered listings from Firestore.")
            }
    }

    
  // fetch listings for a specific user or all listings if `userID` is nil
  func fetchListings(for userID: String? = nil) {
      let query: Query
      if let userID = userID {
          // Fetch only listings that belong to the user
          query = store.collection(path).whereField("userID", isEqualTo: userID)
      } else {
          // Fetch all listings
          query = store.collection(path)
      }

      query.addSnapshotListener { querySnapshot, error in
          if let error = error {
              print("Error fetching listings: \(error.localizedDescription)")
              return
          }

          self.listings = querySnapshot?.documents.compactMap { document in
              try? document.data(as: Listing.self)
          } ?? []
      }
  }
  
    // create new listing
    func createListing(_ listing: Listing, completion: @escaping (Result<Void, Error>) -> Void) {
        do {
            let documentId = listing.id ?? UUID().uuidString
            try store.collection(path).document(documentId).setData(from: listing) { error in
                if let error = error {
                    print("Error creating listing: \(error.localizedDescription)")
                    completion(.failure(error))
                } else {
                    print("Listing created successfully.")
                    completion(.success(()))
                }
            }
        } catch {
            print("Data serialization error: \(error.localizedDescription)")
            completion(.failure(error))
        }
    }
  
  func updateListing(listingID: String, with draft: ListingDraft, userID: String, completion: @escaping (Result<Void, Error>) -> Void) {
      let updatedData: [String: Any] = [
          "title": draft.title,
          "description": draft.description,
          "category": draft.category.rawValue,
          "userID": userID,
          "size": draft.size.rawValue,
          "price": draft.price,
          "color": draft.color.rawValue,
          "condition": draft.condition.rawValue,
          "photoURLs": draft.photoURLs,
          "tags": draft.tags.map { $0.rawValue },
          "brand": draft.brand,
          "maxRentalDuration": draft.maxRentalDuration.rawValue,
          "pickupLocations": draft.pickupLocations.map { $0.rawValue },
          "available": draft.available
      ]

      store.collection("Listings").document(listingID).updateData(updatedData) { error in
          if let error = error {
              completion(.failure(error))
          } else {
              completion(.success(()))
          }
      }
  }


    // upload images to Firebase Storage and return their URLs
    func uploadImages(_ images: [UIImage], completion: @escaping ([String]) -> Void) {
        var uploadedURLs: [String] = []
        let dispatchGroup = DispatchGroup()

        for image in images {
            guard let imageData = image.jpegData(compressionQuality: 0.8) else { continue }
            let imageRef = storage.reference().child("images/\(UUID().uuidString).jpg")
            dispatchGroup.enter()

            imageRef.putData(imageData, metadata: nil) { _, error in
                if let error = error {
                    print("Image upload failed: \(error.localizedDescription)")
                    dispatchGroup.leave()
                    return
                }

                imageRef.downloadURL { url, error in
                    if let url = url {
                        uploadedURLs.append(url.absoluteString)
                    } else if let error = error {
                        print("Failed to get image URL: \(error.localizedDescription)")
                    }
                    dispatchGroup.leave()
                }
            }
        }

        dispatchGroup.notify(queue: .main) {
            print("Image uploads completed. URLs: \(uploadedURLs)")
            completion(uploadedURLs)
        }
    }

    // save listing from draft (after uploading images)
    func saveListingFromDraft(_ draft: ListingDraft, userID: String, completion: @escaping (Result<Void, Error>) -> Void) {
        let listing = Listing(
            id: UUID().uuidString,
            title: draft.title,
            creationTime: draft.creationTime,
            description: draft.description,
            category: draft.category,
            userID: userID,
            size: draft.size,
            price: draft.price,
            color: draft.color,
            condition: draft.condition,
            photoURLs: draft.photoURLs,
            tags: draft.tags,
            brand: draft.brand,
            maxRentalDuration: draft.maxRentalDuration,
            pickupLocations: draft.pickupLocations,
            available: draft.available
        )

        print("Saving listing from draft: \(listing)")
        createListing(listing) { result in
              switch result {
              case .success:
                  // Update the user's document with the new listing ID
                  self.addListingToUser(userID: userID, listingID: listing.id ?? "") { userUpdateResult in
                      completion(userUpdateResult)
                  }
              case .failure(let error):
                  completion(.failure(error))
              }
          }
    }
  
    private func addListingToUser(userID: String, listingID: String, completion: @escaping (Result<Void, Error>) -> Void) {
        let userRef = store.collection("Users").document(userID)
        userRef.updateData([
            "listings": FieldValue.arrayUnion([listingID])
        ]) { error in
            if let error = error {
                completion(.failure(error))
            } else {
                completion(.success(()))
            }
        }
    }

    // delete listing
    func deleteListing(_ id: String, completion: @escaping (Result<Void, Error>) -> Void) {
        store.collection(path).document(id).delete { error in
            if let error = error {
                print("Error deleting listing: \(error.localizedDescription)")
                completion(.failure(error))
            } else {
                print("Listing deleted successfully.")
                completion(.success(()))
            }
        }
    }
}
