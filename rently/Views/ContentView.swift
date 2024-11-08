//
//  ContentView.swift
//  rently
//
//  Created by Grace Liao on 11/2/24.

import SwiftUI

struct ContentView: View {
    @State private var isOnboardingComplete = false
    @State private var isSignUpComplete = false
    @State private var user: User? // Store the newly created user after onboarding

    var body: some View {
        if isOnboardingComplete, let currentUser = user {
            // Show the main app interface with tabs once onboarding is complete
            AppView(user: currentUser)
        } else {
            // Show the onboarding view initially
            OnboardingView(onboardingComplete: { newUser in
                // Set user data and mark onboarding as complete
                self.user = newUser
                self.isOnboardingComplete = true
            })
//            WelcomeView(onSignUpComplete: { newUser in
//                // Set the user data and mark onboarding as complete
//                self.user = newUser
//                self.isOnboardingComplete = true
//            })
        }
    }
}

#Preview {
    ContentView()
}

