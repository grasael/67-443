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
    @ObservedObject var userViewModel: UserViewModel
    @Binding var navigateToAppView: Bool

    var body: some View {
        VStack(spacing: 20) {
            Text("welcome back")
                .font(.largeTitle)
                .fontWeight(.bold)
                .padding(.top)

          Divider()
              .frame(height: 2)
              .overlay(LinearGradient(colors: [Color("MediumGreen"), Color("MediumBlue")], startPoint: .leading, endPoint: .trailing))
              .padding(.horizontal)

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
                LinearGradient(gradient: Gradient(colors: [Color("LightBlue"), Color("Yellow")]), startPoint: .leading, endPoint: .trailing)
            )
            .cornerRadius(20)
            .padding(.horizontal)

            Spacer()
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

    private func signIn() {
        print("🔵 Sign In Button Clicked")
        guard !email.isEmpty, !password.isEmpty else {
            alertMessage = "Email and password cannot be empty."
            showAlert = true
            return
        }

        Auth.auth().signIn(withEmail: email, password: password) { authResult, error in
            if let error = error as NSError? {
                print("❌ Firebase Auth Error: \(error.localizedDescription), Code: \(error.code)")
                DispatchQueue.main.async {
                    alertMessage = "invalid email or password. please try again."
                    showAlert = true
                }
                return
            }

            print("✅ Firebase Auth Success for user: \(authResult?.user.email ?? "unknown email")")

            // Fetch the user data
            UserRepository().fetchUser(byEmail: email) { fetchedUser in
                if let user = fetchedUser {
                    DispatchQueue.main.async {
                        userViewModel.user = user // Update the userViewModel
                        print("✅ UserViewModel is set: \(userViewModel.user)")
                        navigateToAppView = true // Trigger navigation to AppView
                    }
                } else {
                    print("❌ Email not found in database")
                    DispatchQueue.main.async {
                        alertMessage = "we could not find an account associated with this email. please check your credentials and try again."
                        showAlert = true
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
                    SecureField("enter your password", text: $password)
                        .autocapitalization(.none) // Disable autocapitalization
                        .padding(8)
                        .font(.system(size: 14))
                        .background(Color.white)
                        .overlay(
                            RoundedRectangle(cornerRadius: 8)
                                .stroke(Color.gray, lineWidth: 1)
                        )
                } else {
                    TextField("enter your password", text: $password)
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
