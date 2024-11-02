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
    @Published var isLoading = false
    
    private var db = Firestore.firestore()
    
    func fetchData() {
        isLoading = true
        print("Fetching data from Firestore...")
        
        db.collection("Users")
            .addSnapshotListener { (querySnapshot, error) in
                self.isLoading = false
                
                if let error = error {
                    print("Error fetching users: \(error.localizedDescription)")
                    return
                }
                
                guard let documents = querySnapshot?.documents else {
                    print("No documents found in collection.")
                    return
                }
                
                print("Fetched \(documents.count) document(s) from Firestore.")
                
                self.users = documents.compactMap { document in
                    do {
                        let user = try document.data(as: User.self)
                        print("Parsed user: \(user)")
                        return user
                    } catch {
                        print("Error parsing user document: \(error.localizedDescription)")
                        return nil
                    }
                }
                
                print("Total users in array: \(self.users.count)")
            }
    }
}
