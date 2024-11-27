//
//  OnboardingView.swift
//  rently
//
//  Created by Grace Liao on 11/4/24.
//

import SwiftUI

struct OnboardingView: View {
    var onboardingComplete: (User) -> Void
    
    @State private var name = ""
    @State private var lastName = ""
    @State private var username = ""
    @State private var pronouns = ""
    @State private var email = ""
    @State private var password = ""
    @State private var university = ""
    @State private var showErrorAlert = false
    @State private var errorMessage = ""
    @State private var showSuccessAlert = false
    @State private var agreeToTerms = false

    var body: some View {
        VStack(spacing: 20) {
            Text("let's get you set up")
                .font(.title2)
                .fontWeight(.medium)
                .padding(.top, 20)

            Rectangle()
                .frame(height: 1)
                .foregroundColor(Color.green.opacity(0.5))
                .padding(.horizontal)

            VStack(alignment: .leading, spacing: 4) {
                Text("username: *")
                    .foregroundColor(.black)
                    .font(.system(size: 14))
                    .fontWeight(.semibold)

                TextField("", text: $username)
                    .padding(8)
                    .font(.system(size: 14))
                    .background(Color.white)
                    .overlay(
                        RoundedRectangle(cornerRadius: 8)
                            .stroke(Color.gray, lineWidth: 1)
                    )
                    .autocapitalization(.none)

                Text("No special characters or spaces")
                    .font(.system(size: 12))
                    .foregroundColor(.gray)
            }
            .padding(.horizontal)
            
            VStack(alignment: .leading, spacing: 4) {
                Text("first name: *")
                    .foregroundColor(.black)
                    .font(.system(size: 14))
                    .fontWeight(.semibold)

                TextField("", text: $name)
                    .padding(8)
                    .font(.system(size: 14))
                    .background(Color.white)
                    .overlay(
                        RoundedRectangle(cornerRadius: 8)
                            .stroke(Color.gray, lineWidth: 1)
                    )
            }
            .padding(.horizontal)
            
            VStack(alignment: .leading, spacing: 4) {
                Text("last name:")
                    .foregroundColor(.black)
                    .font(.system(size: 14))
                    .fontWeight(.semibold)

                TextField("", text: $lastName)
                    .padding(8)
                    .font(.system(size: 14))
                    .background(Color.white)
                    .overlay(
                        RoundedRectangle(cornerRadius: 8)
                            .stroke(Color.gray, lineWidth: 1)
                    )
            }
            .padding(.horizontal)
            
            VStack(alignment: .leading, spacing: 4) {
                Text("pronouns: *")
                    .foregroundColor(.black)
                    .font(.system(size: 14))
                    .fontWeight(.semibold)

                TextField("", text: $pronouns)
                    .padding(8)
                    .font(.system(size: 14))
                    .background(Color.white)
                    .overlay(
                        RoundedRectangle(cornerRadius: 8)
                            .stroke(Color.gray, lineWidth: 1)
                    )
            }
            .padding(.horizontal)

            VStack(alignment: .leading, spacing: 4) {
                Text("email: *")
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
            }
            .padding(.horizontal)
            
            VStack(alignment: .leading, spacing: 4) {
                Text("university: *")
                    .foregroundColor(.black)
                    .font(.system(size: 14))
                    .fontWeight(.semibold)

                TextField("", text: $university)
                    .padding(8)
                    .font(.system(size: 14))
                    .background(Color.white)
                    .overlay(
                        RoundedRectangle(cornerRadius: 8)
                            .stroke(Color.gray, lineWidth: 1)
                    )
            }
            .padding(.horizontal)

            VStack(alignment: .leading, spacing: 4) {
                Text("password: *")
                    .foregroundColor(.black)
                    .font(.system(size: 14))
                    .fontWeight(.semibold)

                SecureField("", text: $password)
                    .padding(8)
                    .font(.system(size: 14))
                    .background(Color.white)
                    .overlay(
                        RoundedRectangle(cornerRadius: 8)
                            .stroke(Color.gray, lineWidth: 1)
                    )

                VStack(alignment: .leading, spacing: 4) {
                    Text("• 8 characters or more")
                    Text("• At least 1 number")
                    Text("• At least 1 letter")
                }
                .font(.system(size: 12))
                .foregroundColor(.gray)
            }
            .padding(.horizontal)

            HStack {
                Toggle(isOn: $agreeToTerms) {
                    HStack(spacing: 4) {
                        Text("I agree with")
                        Button("terms of use") {
                            // Add action for showing terms of use here
                        }
                        .foregroundColor(.blue)
                        .fontWeight(.semibold)
                    }
                }
                .toggleStyle(SwitchToggleStyle(tint: .blue))
            }
            .padding(.horizontal)
            .font(.system(size: 12))

            Button(action: signUp) {
                Text("Sign Up")
                    .foregroundColor(.white)
                    .padding(.vertical, 10)
                    .padding(.horizontal, 40)
                    .font(.system(size: 16, weight: .semibold))
            }
            .background(
                LinearGradient(
                    gradient: Gradient(colors: [Color.blue, Color.green]),
                    startPoint: .leading,
                    endPoint: .trailing
                )
            )
            .cornerRadius(8)
            .padding(.top, 20)
            .padding(.bottom, 20)
            .padding(.horizontal)

            Spacer()
        }
        .padding()
        .alert(isPresented: $showSuccessAlert) {
            Alert(
                title: Text("Success"),
                message: Text("You have successfully signed up!"),
                dismissButton: .default(Text("OK"))
            )
        }
        .background(Color(red: 0.8, green: 0.93, blue: 1))
        .edgesIgnoringSafeArea(.all)
        .alert(isPresented: $showErrorAlert) {
            Alert(
                title: Text("Error"),
                message: Text(errorMessage),
                dismissButton: .default(Text("OK"))
            )
        }
    }
    
    private func signUp() {
        guard !name.isEmpty, !lastName.isEmpty, !username.isEmpty, !pronouns.isEmpty, !email.isEmpty, !password.isEmpty, !university.isEmpty else {
            errorMessage = "Please fill out all fields."
            showErrorAlert = true
            return
        }

        guard isValidEmail(email) else {
            errorMessage = "Please enter a valid email address."
            showErrorAlert = true
            return
        }

        let newUser = User(
            firstName: name,
            lastName: lastName,
            username: username,
            pronouns: pronouns,
            email: email,
            password: password,
            university: university,
            rating: 0,
            listings: [],
            likedItems: [],
            styleChoices: [],
            events: []
        )

        let userViewModel = UserViewModel(user: newUser)
        userViewModel.addUser()

        onboardingComplete(newUser)

        showSuccessAlert = true
    }

    private func isValidEmail(_ email: String) -> Bool {
        let emailRegex = "^[A-Z0-9._%+-]+@[A-Z0-9.-]+\\.[A-Z]{2,}$"
        let emailPredicate = NSPredicate(format: "SELF MATCHES[c] %@", emailRegex)
        return emailPredicate.evaluate(with: email)
    }
}
