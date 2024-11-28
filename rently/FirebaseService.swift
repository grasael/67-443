//
//  FirebaseService.swift
//  rently
//
//  Created by Grace Liao on 11/7/24.
//

import FirebaseAuth
import FirebaseFirestore
import FirebaseStorage

extension Auth {
    func createUserAsync(withEmail email: String, password: String) async throws -> AuthDataResult {
        return try await withCheckedThrowingContinuation { continuation in
            self.createUser(withEmail: email, password: password) { authResult, error in
                if let error = error {
                    continuation.resume(throwing: error)
                } else if let authResult = authResult {
                    continuation.resume(returning: authResult)
                } else {
                    continuation.resume(throwing: NSError(domain: "FirebaseService", code: -1, userInfo: [NSLocalizedDescriptionKey: "Unknown error"]))
                }
            }
        }
    }
}

class FirebaseService {
  static let shared = FirebaseService()
  
  private init() {}
  
  func registerUser(firstName: String, email: String, password: String) async throws -> User {
    print("Attempting to create user in Firebase Authentication with:")
    print("First Name: \(firstName)")
    print("Email: \(email)")
    print("Password: \(password)")
    
    let authResult = try await Auth.auth().createUserAsync(withEmail: email, password: password)
    let uid = authResult.user.uid
    
    let user = User(
      id: uid,
      firstName: firstName,
      lastName: "",
      username: "",
      pronouns: "",
      email: email,
      password: "",
      university: "",
      rating: 0,
      listings: [],
      likedItems: [],
      styleChoices: [],
      events: []
    )
    
    print("Saving user to Firestore with the following data:")
    try await saveUserToFirestore(user)
    return user
  }
  
  private func saveUserToFirestore(_ user: User) async throws {
    let db = Firestore.firestore()
    try db.collection("Users").document(user.id!).setData(from: user)
  }
  
  
  // save Listing to Firestore
  func saveListing(_ listing: Listing, completion: @escaping (Result<Void, Error>) -> Void) {
    let db = Firestore.firestore()
    do {
      let data = try Firestore.Encoder().encode(listing)
      
      db.collection("Listings").document(listing.id ?? UUID().uuidString).setData(data) { error in
        if let error = error {
          print("Firestore save error:", error)
          completion(.failure(error))
        } else {
          print("Listing successfully saved.")
          completion(.success(()))
        }
      }
    } catch {
      print("Data serialization error:", error)
      completion(.failure(error))
    }
  }
}
