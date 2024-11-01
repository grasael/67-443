//
//  UserViewModel.swift
//  rently
//
//  Created by Grace Liao on 11/1/24.
//

import Foundation
import FirebaseFirestore

class UserViewModel: ObservableObject {
    @Published var users = [User]()
    
    private var db = Firestore.firestore()
    
    func fetchData() {
        db.collection("users").addSnapshotListener { (querySnapshot, error) in guard let documents = querySnapshot?.documents else {
            print("No documents")
            return
        }
            self.users = documents.compactMap { (QueryDocumentSnapshot) -> User? in return try? QueryDocumentSnapshot.data(as: User.self)
                
        }
        }
    }
}
