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

    // Fetch users from Firestore
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

    // MARK: CRUD Methods
    func create(_ user: User) {
        do {
            let newUser = user
            _ = try store.collection(path).addDocument(from: newUser)
            print("User added to Firestore") // Preserved print statement
        } catch {
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

