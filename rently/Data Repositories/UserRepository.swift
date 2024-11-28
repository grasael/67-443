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
  func create(_ user: User, completion: @escaping (User) -> Void) {
      do {
          let documentRef = try store.collection(path).addDocument(from: user)
          
          // Fetch the document ID and update the user object
          var newUser = user
          newUser.id = documentRef.documentID
          print("User created successfully with ID:", newUser.id ?? "nil")
          
          // Call the completion handler with the updated user
          completion(newUser)
      } catch {
          print("Error creating user:", error.localizedDescription)
          fatalError("Unable to add user: \(error.localizedDescription).")
      }
  }



  func update(_ user: User) {
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
  
}
