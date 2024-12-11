//
//  SignInView.swift
//  rently
//
//  Created by Grace Liao on 11/7/24.
//

import SwiftUI
import FirebaseAuth

struct SignInView: View {
    @State private var email = ""
    @State private var password = ""
    @State private var showAlert = false
    @State private var alertMessage = ""
    @State private var navigateToAppView = false
    @State private var userViewModel: UserViewModel? = nil
    
    var body: some View {
        NavigationStack {
            VStack(spacing: 20) {
                Text("welcome back")
                    .font(.largeTitle)
                    .fontWeight(.bold)
                    .padding(.top)
                
                Divider()
                
                EmailField(email: $email)
                PasswordField(password: $password)
                
                // Sign In Button
                Button(action: signIn) {
                    Text("sign in")
                        .foregroundColor(.white)
                        .padding(.vertical, 10)
                        .padding(.horizontal, 40)
                        .frame(maxWidth: .infinity)
                }
                .background(
                    LinearGradient(gradient: Gradient(colors: [Color.blue, Color.green]), startPoint: .leading, endPoint: .trailing)
                )
                .cornerRadius(8)
                .padding(.horizontal)
                
                Spacer()
            }
            .fullScreenCover(isPresented: $navigateToAppView) {
                if let userViewModel = userViewModel {
                    AppView(viewModel: userViewModel)
                        .onAppear {
                            print("✅ AppView appeared with UserViewModel: \(userViewModel)") // Debug
                        }
                        .onDisappear {
                            print("🟢 AppView dismissed, resetting navigation state") // Debug
                            navigateToAppView = false
                        }
                } else {
                    Text("Failed to load user data.")
                        .font(.title)
                }
            }
            .padding()
            .alert(isPresented: $showAlert) {
                Alert(
                    title: Text("Error"),
                    message: Text(alertMessage),
                    dismissButton: .default(Text("OK"))
                )
            }
        }
    }
    
    private func signIn() {
        print("🔵 Sign In Button Clicked") // Debug
        print("Email: \(email), Password: \(password)") // Debug
        print("Attempting to sign in with email: \(email)") // Debug

        // Sign in with Firebase Authentication
        Auth.auth().signIn(withEmail: email, password: password) { authResult, error in
            if let error = error as NSError? {
                // Handle Firebase Auth errors
                print("❌ Firebase Auth Error: \(error.localizedDescription), Code: \(error.code)") // Debug

                switch AuthErrorCode(rawValue: error.code) {
                case .wrongPassword:
                    self.alertMessage = "Incorrect password. Please try again."
                case .userNotFound:
                    self.alertMessage = "No account found with this email."
                case .invalidEmail:
                    self.alertMessage = "Invalid email format. Please check your email."
                default:
                    self.alertMessage = error.localizedDescription
                }
                self.showAlert = true
            } else {
                print("✅ Sign In Success for user: \(authResult?.user.email ?? "unknown email")") // Debug

                // Fetch user details from Firestore
                UserRepository().fetchUser(byEmail: email) { fetchedUser in
                    if let user = fetchedUser {
                        print("✅ Fetched User from Firestore: \(user)") // Debug

                        DispatchQueue.main.async {
                            self.userViewModel = UserViewModel(user: user)
                            //print("✅ Initializing UserViewModel with user ID: \(user._id)")
                            self.navigateToAppView = true
                            print("🟢 Navigate to AppView triggered") // Debug
                        }
                    } else {
                        print("❌ Failed to fetch user data from Firestore") // Debug
                        self.alertMessage = "Failed to retrieve user data. Please try again."
                        self.showAlert = true
                    }
                }
            }
        }
    }
}

private struct EmailField: View {
    @Binding var email: String
    var body: some View {
        VStack(alignment: .leading, spacing: 4) {
            Text("email:")
                .foregroundColor(.black)
                .font(.system(size: 14))
                .fontWeight(.semibold)
            
            TextField("", text: $email)
                .padding(8)
                .font(.system(size: 14))
                .background(Color.white)
                .overlay(
                    RoundedRectangle(cornerRadius: 8)
                        .stroke(Color.gray, lineWidth: 1)
                )
                .autocapitalization(.none)
        }
        .padding(.horizontal)
    }
}
private struct PasswordField: View {
    @Binding var password: String
    @State private var isSecure: Bool = true // Tracks visibility state of the password
    var body: some View {
        VStack(alignment: .leading, spacing: 4) {
            Text("password:")
                .foregroundColor(.black)
                .font(.system(size: 14))
                .fontWeight(.semibold)
            HStack {
                if isSecure {
                    SecureField("Enter your password", text: $password)
                        .autocapitalization(.none) // Disable autocapitalization
                        .padding(8)
                        .font(.system(size: 14))
                        .background(Color.white)
                        .overlay(
                            RoundedRectangle(cornerRadius: 8)
                                .stroke(Color.gray, lineWidth: 1)
                        )
                } else {
                    TextField("Enter your password", text: $password)
                        .autocapitalization(.none) // Disable autocapitalization
                        .padding(8)
                        .font(.system(size: 14))
                        .background(Color.white)
                        .overlay(
                            RoundedRectangle(cornerRadius: 8)
                                .stroke(Color.gray, lineWidth: 1)
                        )
                }
                // Eye icon to toggle visibility
                Button(action: {
                    isSecure.toggle() // Toggle visibility state
                }) {
                    Image(systemName: isSecure ? "eye.slash" : "eye")
                        .foregroundColor(.gray)
                }
            }
        }
        .padding(.horizontal)
    }
}
