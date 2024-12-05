//
//  ContentView.swift
//  rently
//
//  Created by Grace Liao on 11/2/24.

import SwiftUI

struct ContentView: View {
    @State private var isOnboardingComplete = false
    @ObservedObject private var userManager = UserManager.shared

    var body: some View {
        if let currentUser = userManager.user {
            AppView(user: currentUser)
        } else {
            OnboardingView(onboardingComplete: { newUser in
                userManager.saveUser(newUser)  // Save user to UserManager
                isOnboardingComplete = true
            })
        }
    }
}

#Preview {
    ContentView()
}

