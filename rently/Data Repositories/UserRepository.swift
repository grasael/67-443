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
    func create(_ user: User) {
        do {
            var newUser = user
            let docRef = try store.collection(path).addDocument(from: newUser)
            
            docRef.getDocument { documentSnapshot, error in
                if let documentSnapshot = documentSnapshot, documentSnapshot.exists {
                    newUser.id = documentSnapshot.documentID
                    UserManager.shared.saveUser(newUser)
                    print("User added to Firestore and set in UserManager")
                } else if let error = error {
                    print("Error fetching document: \(error.localizedDescription)")
                }
            }
        } catch {
            fatalError("Unable to add user: \(error.localizedDescription).")
        }
    }

    func update(_ user: User) {
        guard let userId = user.id else { return }

        do {
            try store.collection(path).document(userId).setData(from: user) { error in
                if let error = error {
                    print("Unable to update user: \(error.localizedDescription)")
                } else {
                    UserManager.shared.saveUser(user)
                    print("User updated in Firestore and set in UserManager")
                }
            }
        } catch {
            fatalError("Unable to update user: \(error.localizedDescription).")
        }
    }

    func delete(_ user: User) {
        guard let userId = user.id else { return }

        store.collection(path).document(userId).delete { error in
            if let error = error {
                print("Unable to remove user: \(error.localizedDescription)")
            } else {
                if UserManager.shared.user?.id == userId {
                    UserManager.shared.clearUser()
                    print("User removed from Firestore and cleared from UserManager")
                }
            }
        }
    }
}
