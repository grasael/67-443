//
//  ReviewRepository.swift
//  rently
//
//  Created by Grace Liao on 11/7/24.
//
<<<<<<< HEAD
//
//  ReviewRepository.swift
//  rently
//
//  Created by Grace Liao on 11/7/24.
//

import Foundation
import Combine
import FirebaseFirestore

class ReviewRepository: ObservableObject {
  private let path: String = "Reviews"
  private let store = Firestore.firestore()

  @Published var reviews: [Review] = []
  private var cancellables: Set<AnyCancellable> = []

  init() {
    self.get()
  }

  func get() {
    store.collection(path)
      .addSnapshotListener { querySnapshot, error in
        if let error = error {
          print("Error getting review: \(error.localizedDescription)")
          return
        }

        self.reviews = querySnapshot?.documents.compactMap { document in
          try? document.data(as: Review.self)
        } ?? []
      }
  }

  // MARK: CRUD methods
  func create(_ review: Review) {
    do {
      let newReview = review
      _ = try store.collection(path).addDocument(from: newReview)
    } catch {
      fatalError("Unable to add review: \(error.localizedDescription).")
    }
  }

  func update(_ review: Review) {
    guard let reviewId = review.id else { return }
    
    do {
      try store.collection(path).document(reviewId).setData(from: review)
    } catch {
      fatalError("Unable to update review: \(error.localizedDescription).")
    }
  }

  func delete(_ review: Review) {
    guard let reviewId = review.id else { return }
    
    store.collection(path).document(reviewId).delete { error in
      if let error = error {
        print("Unable to remove review: \(error.localizedDescription)")
      }
    }
  }
  
=======
import Foundation
import Combine
import FirebaseFirestore
import FirebaseAuth

class ReviewRepository: ObservableObject {
    private let path: String = "Reviews"
    private let store = Firestore.firestore()
    
    @Published var reviews: [Review] = []
    private var cancellables: Set<AnyCancellable> = []

    init() {
        self.get()
    }

    func get() {
        guard let userID = Auth.auth().currentUser?.uid else {
            print("No user is logged in")
            return
        }
        
        store.collection(path)
            .whereField("userID", isEqualTo: userID) // Filter reviews by the current user's ID
            .addSnapshotListener { querySnapshot, error in
                if let error = error {
                    print("Error getting reviews: \(error.localizedDescription)")
                    return
                }
                
                self.reviews = querySnapshot?.documents.compactMap { document in
                    try? document.data(as: Review.self)
                } ?? []
            }
    }

    // MARK: CRUD methods
    func create(_ review: Review) {
        do {
            var newReview = review
            newReview.userID = Auth.auth().currentUser!.uid // Set user ID for the review
            _ = try store.collection(path).addDocument(from: newReview)
        } catch {
            fatalError("Unable to add review: \(error.localizedDescription).")
        }
    }

    func update(_ review: Review) {
        guard let reviewId = review.id else { return }
        
        do {
            try store.collection(path).document(reviewId).setData(from: review)
        } catch {
            fatalError("Unable to update review: \(error.localizedDescription).")
        }
    }

    func delete(_ review: Review) {
        guard let reviewId = review.id else { return }
        
        store.collection(path).document(reviewId).delete { error in
            if let error = error {
                print("Unable to remove review: \(error.localizedDescription)")
            }
        }
    }
>>>>>>> main
}
