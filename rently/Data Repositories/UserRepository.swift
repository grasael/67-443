//
//  UserRepository.swift
//  rently
//
//  Created by Grace Liao on 11/7/24.
//

import Foundation
import Combine
import FirebaseFirestore


class UserRepository: ObservableObject {
  private let path: String = "Users"
  private let store = Firestore.firestore()

  @Published var users: [User] = []
  private var cancellables: Set<AnyCancellable> = []

  init() {
    self.get()
  }

  func get() {
    store.collection(path)
      .addSnapshotListener { querySnapshot, error in
        if let error = error {
          print("Error getting users: \(error.localizedDescription)")
          return
        }

        self.users = querySnapshot?.documents.compactMap { document in
          try? document.data(as: User.self)
        } ?? []
      }
  }

  // MARK: CRUD methods
//  func create(_ user: User) {
//    do {
//      let newUser = user
//      _ = try store.collection(path).addDocument(from: newUser)
//        print("User added to Firestore")
//    } catch {
//      fatalError("Unable to add user: \(error.localizedDescription).")
//    }
//  }
    
    func create(_ user: User) {
        do {
            // Add user to Firestore and get the DocumentReference
            let documentReference = try store.collection(path).addDocument(from: user)
            
            // Print the Document ID
            print("User added to Firestore with Document ID: \(documentReference.documentID)")
        } catch {
            fatalError("Unable to add user: \(error.localizedDescription).")
        }
    }
    
  func update(_ user: User) {
    print("USER ID is \(user.id)")
    guard let userId = user.id else { return }
    do {
      try store.collection(path).document(userId).setData(from: user)
    } catch {
      fatalError("Unable to update user: \(error.localizedDescription).")
    }
  }

  func delete(_ user: User) {
    guard let userId = user.id else { return }
    
    store.collection(path).document(userId).delete { error in
      if let error = error {
        print("Unable to remove user: \(error.localizedDescription)")
      }
    }
  }
    
    // Add a follower
    func addFollower(to userID: String, followerID: String) {
        let userRef = store.collection(path).document(userID)
        userRef.updateData([
            "followers": FieldValue.arrayUnion([followerID])
        ]) { error in
            if let error = error {
                print("Error adding follower: \(error.localizedDescription)")
            } else {
                print("Follower added successfully to user \(userID).")
            }
        }
    }

    // Remove a follower
    func removeFollower(from userID: String, followerID: String) {
        let userRef = store.collection(path).document(userID)
        userRef.updateData([
            "followers": FieldValue.arrayRemove([followerID])
        ]) { error in
            if let error = error {
                print("Error removing follower: \(error.localizedDescription)")
            } else {
                print("Follower removed successfully from user \(userID).")
            }
        }
    }

    // Add to following
    func addFollowing(for userID: String, followingID: String) {
        let userRef = store.collection(path).document(userID)
        userRef.updateData([
            "following": FieldValue.arrayUnion([followingID])
        ]) { error in
            if let error = error {
                print("Error adding to following: \(error.localizedDescription)")
            } else {
                print("Following added successfully for user \(userID).")
            }
        }
    }

    // Remove from following
    func removeFollowing(for userID: String, followingID: String) {
        let userRef = store.collection(path).document(userID)
        userRef.updateData([
            "following": FieldValue.arrayRemove([followingID])
        ]) { error in
            if let error = error {
                print("Error removing from following: \(error.localizedDescription)")
            } else {
                print("Following removed successfully for user \(userID).")
            }
        }
    }
  
}
