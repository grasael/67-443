//
//  LoadingView.swift
//  rently
//
//  Created by Grace Liao on 12/12/24.
//
import SwiftUI

struct LoadingView: View {
    @State private var isVerified = false
    @State private var showErrorAlert = false
    @State private var currentMessage = "Starting verification process..."
    @State private var messageIndex = 0
    @Environment(\.presentationMode) var presentationMode
    var email: String
    var university: String
    var userViewModel: UserViewModel

    private var verificationMessages: [String] {
        [
            "Starting verification process...",
            "Connecting to \(university)'s servers...",
            "Verifying email domain...",
            "Checking student database records...",
            "Finalizing the verification..."
        ]
    }

    var body: some View {
        ZStack {
            // Background gradient
            LinearGradient(
                gradient: Gradient(colors: [Color("Yellow"), Color("MediumBlue")]),
                startPoint: .top,
                endPoint: .bottom
            )
            .ignoresSafeArea()

            VStack(spacing: 20) {
                Text("Verifying your student status...")
                    .font(.title)
                    .fontWeight(.bold)
                    .multilineTextAlignment(.center)
                    .padding(.top, 20)

                Spacer()

                ProgressView()
                    .progressViewStyle(CircularProgressViewStyle(tint: Color("MediumBlue")))
                    .scaleEffect(1.5)

                Text(currentMessage)
                    .font(.subheadline)
                    .foregroundColor(.black)
                    .multilineTextAlignment(.center)
                    .padding(.horizontal)
                    .padding(.top, 20)

                Spacer()
            }
        }
        .onAppear {
            startVerificationProcess()
        }
        .alert(isPresented: $showErrorAlert) {
            Alert(
                title: Text("Verification Failed"),
                message: Text("Please use your school-issued email ending in .edu."),
                dismissButton: .default(Text("OK"), action: {
                    presentationMode.wrappedValue.dismiss() // Return to VerifyView
                })
            )
        }
        .overlay(
            NavigationLink(
                destination: VerifiedView(userViewModel: userViewModel, email: email, university: university),
                isActive: $isVerified
            ) {
                EmptyView()
            }
        )
        .navigationBarHidden(true)
    }

    private func startVerificationProcess() {
        // Display each message with a delay
        for (index, message) in verificationMessages.enumerated() {
            DispatchQueue.main.asyncAfter(deadline: .now() + Double(index) * 2.0) { // Adjust timing as needed
                currentMessage = message
                messageIndex = index

                // At the last message, validate the email
                if index == verificationMessages.count - 1 {
                    validateEmail()
                }
            }
        }
    }

    private func validateEmail() {
        DispatchQueue.main.asyncAfter(deadline: .now() + 2.0) { // Add a short delay before finalizing
            if email.hasSuffix(".edu") {
                isVerified = true // Navigate to VerifiedView
            } else {
                showErrorAlert = true // Show error alert
            }
        }
    }
}
