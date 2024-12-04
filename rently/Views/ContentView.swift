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
        NavigationView {
            if isOnboardingComplete, let currentUser = user {
                AppView(user: currentUser)
            } else {
                WelcomeView(onboardingComplete: { newUser in
                    self.user = newUser
                    self.isOnboardingComplete = true
                })
            }
        }
    }
}


#Preview {
    ContentView()
}

