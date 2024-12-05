//
//  ContentView.swift
//  rently
//
//  Created by Grace Liao on 11/2/24.

import SwiftUI

struct ContentView: View {
//    @State private var isOnboardingComplete = false
//    @State private var user: User?
//    @StateObject private var userViewModel = UserViewModel(user: User(firstName: "", lastName: "", username: "", pronouns: "", email: "", password: "", university: "", rating: 0, listings: [], likedItems: [], styleChoices: [], events: [], followers: [], following: []))
    
    @StateObject private var userViewModel = UserViewModel(user: User(firstName: "", lastName: "", username: "", pronouns: "", email: "", password: "", university: "", rating: 0, listings: [], likedItems: [], styleChoices: [], events: [], followers: [], following: []))


    var body: some View {
        NavigationView {
//            if isOnboardingComplete, let currentUser = user {
//                AppView(userViewModel: userViewModel)
//            } else {
//                WelcomeView(onboardingComplete: { newUser in
//                    self.user = newUser
//                    self.userViewModel.user = newUser // Update the user in the ViewModel
//                    self.isOnboardingComplete = true
//                })
//            }
            
            WelcomeView(userViewModel: userViewModel)
        }
    }
}

#Preview {
    ContentView()
}
