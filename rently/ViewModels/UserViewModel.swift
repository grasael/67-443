//
//  UserViewModel.swift
//  rently
//
//  Created by Grace Liao on 11/1/24.
//

import Foundation
import Combine

class UserViewModel: ObservableObject, Identifiable {
    private let userRepository = UserRepository()
    @Published var user: User
    private var cancellables: Set<AnyCancellable> = []
    var id = ""

    init(user: User) {
        self.user = user
        print("❌ Initializing UserViewModel with user ID: \(user.id ?? "nil") at \(Date())")
        $user
            .compactMap { $0.id }
            .assign(to: \.id, on: self)
            .store(in: &cancellables)
    }

  func addUser() {
          userRepository.create(user) { [weak self] documentID in
              guard let self = self else { return }
              if let documentID = documentID {
                  print("🔥 User ID set to: \(documentID)")
                  self.user.id = documentID // Set the user's ID
                  self.updateUser() // Save the updated user with the ID to Firestore
              } else {
                  print("❌ Failed to create user in Firestore.")
              }
          }
      }

  func updateUser() {
          print("Updating user with ID: \(user.id ?? "no ID")")
          print("Current user data: \(user)")
          userRepository.update(user)
      }
  
  func deleteUser() {
          userRepository.delete(user)
      }
    
  func followUser(userID: String) {
             guard let currentUserID = user.id else { return }
             userRepository.addFollowing(for: currentUserID, followingID: userID)
             userRepository.addFollower(to: userID, followerID: currentUserID)
             if !user.following.contains(userID) {
                 user.following.append(userID)
             }
         }

       func unfollowUser(userID: String) {
           guard let currentUserID = user.id else { return }
           userRepository.removeFollowing(for: currentUserID, followingID: userID)
           userRepository.removeFollower(from: userID, followerID: currentUserID)
           if let index = user.following.firstIndex(of: userID) {
               user.following.remove(at: index)
           }
       }
    
    func fetchFollowingUsers(completion: @escaping ([User]) -> Void) {
        userRepository.fetchUsers(withIDs: user.following) { users in
            DispatchQueue.main.async {
                completion(users)
            }
        }
    }

}
