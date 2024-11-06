//
//  OnboardingView.swift
//  rently
//
//  Created by Grace Liao on 11/4/24.
//

import SwiftUI
import UIKit

struct OnboardingView: View {
    @State private var name = ""
    @State private var email = ""
    @State private var password = ""

    var body: some View {
        VStack(spacing: 20) {
            Text("let's get you started")
                .font(.largeTitle)
                .fontWeight(.bold)
                .padding(.top)
            Divider()

            TextField("first name", text: $name)
                .padding()
                .background(Color.gray.opacity(0.2))
                .cornerRadius(8)
                .padding(.horizontal)

            TextField("email", text: $email)
                .padding()
                .background(Color.gray.opacity(0.2))
                .cornerRadius(8)
                .padding(.horizontal)
                .keyboardType(.emailAddress)
                .autocapitalization(.none)

            SecureField("password", text: $password)
                .padding()
                .background(Color.gray.opacity(0.2))
                .cornerRadius(8)
                .padding(.horizontal)

            Button(action: {
                print("Sign up tapped with Name: \(name), Email: \(email), Password: \(password)")
            }) {
                Text("Sign Up")
                    .foregroundColor(.white)
                    .padding()
                    .frame(maxWidth: .infinity)
            }
            .background(
                LinearGradient(gradient: Gradient(colors: [Color(Color.blue), Color(Color.green)]), startPoint: .leading, endPoint: .trailing)
            )
            .cornerRadius(8)
            .padding(.horizontal)
            
            Spacer()
        }
        .padding()
    }
}

#Preview {
    OnboardingView()
}
