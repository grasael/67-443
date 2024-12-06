//
//  UserManager.swift
//  rently
//
//  Created by Tishyaa Chaudhry on 12/5/24.
//

import Foundation
import SwiftUI
import FirebaseFirestore
import Combine

class UserManager: ObservableObject {
    static let shared = UserManager()
    
    @Published var user: User?
    private var userListener: ListenerRegistration? // Listener for Firestore updates
    
    private init() {}
    
    func saveUser(_ user: User) {
        print("Saving user: \(user)")
        self.user = user
        startListeningToUserChanges(userID: user.id)
    }

    func clearUser() {
        self.user = nil
        stopListeningToUserChanges()
    }
    
    private func startListeningToUserChanges(userID: String?) {
        guard let userID = userID else {
            print("No user ID provided for listening")
            return
        }
        
        // Stop any previous listener to avoid duplicates
        stopListeningToUserChanges()
        
        // Start listening to changes for the specific user
        let db = Firestore.firestore()
        userListener = db.collection("Users").document(userID).addSnapshotListener { [weak self] documentSnapshot, error in
            guard let self = self else { return }
            if let error = error {
                print("Error listening to user document: \(error.localizedDescription)")
                return
            }
            
            guard let data = documentSnapshot?.data() else {
                print("No user data found")
                return
            }
            
            // Update the user object with the latest data
            self.user = try? documentSnapshot?.data(as: User.self)
        }
    }
    
    private func stopListeningToUserChanges() {
        userListener?.remove()
        userListener = nil
    }
}
