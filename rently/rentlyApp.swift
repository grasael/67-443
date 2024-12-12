//
//  rentlyApp.swift
//  rently
//
//  Created by Grace Liao on 10/26/24.
//

import SwiftUI
import FirebaseCore
import FirebaseFirestore
import FirebaseAuth

class AppDelegate: NSObject, UIApplicationDelegate {
    func application(_ application: UIApplication,
                     didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey : Any]? = nil) -> Bool {
        FirebaseApp.configure()
        // Run user migration
        migrateUsers()
        return true
    }
    
    private func migrateUsers() {
        // Comment out the migration flag check for now
        // let hasMigrated = UserDefaults.standard.bool(forKey: "hasMigratedUsers")
        // if hasMigrated {
        //     print("Migration already completed.")
        //     return
        // }

        let db = Firestore.firestore()

        db.collection("Users").getDocuments { (snapshot, error) in
            if let error = error {
                print("❌ Error fetching users: \(error.localizedDescription)")
                return
            }

            guard let documents = snapshot?.documents else {
                print("No users to migrate.")
                return
            }

            for document in documents {
                let data = document.data()

                if let email = data["email"] as? String,
                   let password = data["password"] as? String {
                    Auth.auth().createUser(withEmail: email, password: password) { authResult, error in
                        if let error = error {
                            print("❌ Error creating user \(email): \(error.localizedDescription)")
                        } else if let authResult = authResult {
                            let userUID = authResult.user.uid
                            print("✅ Successfully created user: \(email) with UID: \(userUID)")

                            var userData = data
                            //userData["password"] = nil

                            db.collection("Users").document(userUID).setData(userData) { error in
                                if let error = error {
                                    print("❌ Error writing Firestore data for \(email): \(error.localizedDescription)")
                                } else {
                                    print("✅ Successfully migrated Firestore data for \(email) to UID-based document.")
//                                    document.reference.delete { error in
//                                        if let error = error {
//                                            print("❌ Error deleting old document for \(email): \(error.localizedDescription)")
//                                        } else {
//                                            print("✅ Successfully deleted old document for \(email)")
//                                        }
//                                    }
                                }
                            }
                        }
                    }
                } else {
                    print("❌ Skipping user with missing email or password: \(document.documentID)")
                }
            }

            // Leave this commented during testing
            // UserDefaults.standard.set(true, forKey: "hasMigratedUsers")
        }
    }

}

@main
struct rentlyApp: App {
    // Register app delegate for Firebase setup
    @UIApplicationDelegateAdaptor(AppDelegate.self) var delegate

    var body: some Scene {
        WindowGroup {
            NavigationView {
                ContentView() // Use ContentView as the main view
            }
        }
    }
}

