//
//  ContentView.swift
//  rently
//
//  Created by Grace Liao on 11/2/24.

import SwiftUI
struct ContentView: View {
  @StateObject private var userViewModel = UserViewModel(user: User(firstName: "", lastName: "", username: "", pronouns: "", email: "", password: "", university: "", rating: 0, listings: [], likedItems: [], styleChoices: [], events: [], followers: [], following: [], renting: [], myItems: []))
    var body: some View {
        NavigationView {
            WelcomeView(userViewModel: userViewModel)
        }
    }
}
#Preview {
    ContentView()
}

