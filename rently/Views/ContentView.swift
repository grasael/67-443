//
//  ContentView.swift
//  rently
//
//  Created by Grace Liao on 11/2/24.

import SwiftUI

struct ContentView: View {
    @State private var isOnboardingComplete = false
    @State private var user: User?

    var body: some View {
        if isOnboardingComplete, let currentUser = user {
            AppView(user: currentUser)
        } else {
            OnboardingView(onboardingComplete: { newUser in
                self.user = newUser
                 //set UserManager user here
                self.isOnboardingComplete = true
            })
        }
    }
}

#Preview {
    ContentView()
}

