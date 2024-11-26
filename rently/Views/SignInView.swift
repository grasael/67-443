//
//  SignInView.swift
//  rently
//
//  Created by Grace Liao on 11/7/24.
//

import SwiftUI
import FirebaseAuth
import FirebaseFirestore

struct SignInView: View {
    @State private var email = ""
    @State private var password = ""
    @State private var showAlert = false
    @State private var alertMessage = ""
    @State private var navigateToProfile = false
    @State private var user: User? = nil

    var body: some View {
        NavigationView {
            VStack(spacing: 20) {
                Text("Welcome Back")
                    .font(.largeTitle)
                    .fontWeight(.bold)
                    .padding(.top)
                
                Divider()
                
                // Email TextField
                TextField("Email", text: $email)
                    .padding()
                    .background(Color.gray.opacity(0.2))
                    .cornerRadius(8)
                    .padding(.horizontal)
                    .keyboardType(.emailAddress)
                    .autocapitalization(.none)
                
                // Password SecureField
                SecureField("Password", text: $password)
                    .padding()
                    .background(Color.gray.opacity(0.2))
                    .cornerRadius(8)
                    .padding(.horizontal)
                
                // Sign In Button
                Button(action: signIn) {
                    Text("Sign In")
                        .foregroundColor(.white)
                        .padding()
                        .frame(maxWidth: .infinity)
                }
                .background(
                    LinearGradient(gradient: Gradient(colors: [Color.blue, Color.green]), startPoint: .leading, endPoint: .trailing)
                )
                .cornerRadius(8)
                .padding(.horizontal)
                
                Spacer()
                
                // Navigation link to ProfileView (to be triggered after successful login)
//                if let user = user {
//                    //NavigationLink(destination: ProfileView(userViewModel: userViewModel), isActive: $navigateToProfile)
//                    {
//                        EmptyView()
//                    }
//                }
            }
            .padding()
            .alert(isPresented: $showAlert) {
                Alert(
                    title: Text(""),
                    message: Text(alertMessage),
                    dismissButton: .default(Text("OK")) {
                        if alertMessage == "You have successfully signed in!" {
                            // Attempt to navigate to ProfileView after fetching user data
                            fetchUserData()
                        }
                    }
                )
            }
        }
    }
    
    // Sign In Method using Firebase Authentication
    private func signIn() {
        guard !email.isEmpty, !password.isEmpty else {
            alertMessage = "Please enter both email and password."
            showAlert = true
            return
        }
        
        Auth.auth().signIn(withEmail: email, password: password) { authResult, error in
            if let error = error {
                self.alertMessage = error.localizedDescription
                self.showAlert = true
            } else {
                // Sign-in was successful
                self.alertMessage = "You have successfully signed in!"
                self.showAlert = true
            }
        }
    }
    
    // Fetch user data from Firestore after sign-in
    private func fetchUserData() {
        guard let userID = Auth.auth().currentUser?.uid else {
            self.alertMessage = "Unable to retrieve user data."
            self.showAlert = true
            return
        }
        
        let db = Firestore.firestore()
        db.collection("Users").document(userID).getDocument { (document, error) in
            if let document = document, document.exists {
                do {
                    let userData = try document.data(as: User.self)
                    self.user = userData
                    self.navigateToProfile = true // Trigger navigation
                } catch {
                    self.alertMessage = "Failed to decode user data."
                    self.showAlert = true
                }
            } else {
                self.alertMessage = "User data does not exist."
                self.showAlert = true
            }
        }
    }
}
