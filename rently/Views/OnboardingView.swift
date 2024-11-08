//
//  OnboardingView.swift
//  rently
//
//  Created by Grace Liao on 11/4/24.
//
import SwiftUI

struct OnboardingView: View {
    @State private var name = ""
    @State private var lastName = ""
    @State private var username = ""
    @State private var pronouns = ""
    @State private var email = ""
    @State private var password = ""
    @State private var university = ""
    @State private var showErrorAlert = false
    @State private var errorMessage = ""

    var body: some View {
        VStack(spacing: 20) {
            Text("Let's get you started")
                .font(.largeTitle)
                .fontWeight(.bold)
                .padding(.top)
            Divider()

            TextField("First Name", text: $name)
                .padding()
                .background(Color.gray.opacity(0.2))
                .cornerRadius(8)
                .padding(.horizontal)
            
            TextField("Last Name", text: $lastName)
                .padding()
                .background(Color.gray.opacity(0.2))
                .cornerRadius(8)
                .padding(.horizontal)
            
            TextField("Username", text: $username)
                .padding()
                .background(Color.gray.opacity(0.2))
                .cornerRadius(8)
                .padding(.horizontal)
            
            TextField("Pronouns", text: $pronouns)
                .padding()
                .background(Color.gray.opacity(0.2))
                .cornerRadius(8)
                .padding(.horizontal)

            TextField("Email", text: $email)
                .padding()
                .background(Color.gray.opacity(0.2))
                .cornerRadius(8)
                .padding(.horizontal)
                .keyboardType(.emailAddress)
                .autocapitalization(.none)

            SecureField("Password", text: $password)
                .padding()
                .background(Color.gray.opacity(0.2))
                .cornerRadius(8)
                .padding(.horizontal)
            
            TextField("University", text: $university)
                .padding()
                .background(Color.gray.opacity(0.2))
                .cornerRadius(8)
                .padding(.horizontal)

            Button(action: signUp) {
                Text("Sign Up")
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
        }
        .padding()
        .alert(isPresented: $showErrorAlert) {
            Alert(title: Text("Error"), message: Text(errorMessage), dismissButton: .default(Text("OK")))
        }
    }
    
    private func signUp() {
        guard !name.isEmpty, !lastName.isEmpty, !username.isEmpty, !pronouns.isEmpty, !email.isEmpty, !password.isEmpty, !university.isEmpty else {
            errorMessage = "Please fill out all fields."
            showErrorAlert = true
            return
        }

        // Create a User instance with the collected data
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
        
        // Create a UserViewModel instance to handle adding the user
        let userViewModel = UserViewModel(user: newUser)
        userViewModel.addUser()
        
        print("User added successfully.")
        // Perform any navigation or UI updates here
    }
}

#Preview {
    OnboardingView()
}
