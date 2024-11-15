//
//  ContentView.swift
//  rently
//
//  Created by Grace Liao on 11/2/24.
<<<<<<< HEAD
=======
//
>>>>>>> main

import SwiftUI

struct ContentView: View {
<<<<<<< HEAD
    @State private var isOnboardingComplete = false
    @State private var user: User?

    var body: some View {
        if isOnboardingComplete, let currentUser = user {
            AppView(user: currentUser)
        } else {
            OnboardingView(onboardingComplete: { newUser in
                self.user = newUser
                self.isOnboardingComplete = true
            })
        }
    }
}

#Preview {
    ContentView()
}

=======
    @StateObject private var viewModel = UserViewModel()

    var body: some View {
        NavigationView {
            if viewModel.isLoading {
                VStack {
                    ProgressView()
                    Text("Loading data...")
                        .padding(.top, 10)
                }
            } else if viewModel.users.isEmpty {
                VStack {
                    Text("No users available")
                        .font(.title)
                        .foregroundColor(.gray)
                }
            } else {
                List(viewModel.users) { user in
                    VStack(alignment: .leading) {
                        Text(user.firstName)
                            .font(.headline)
                        Text(user.lastName)
                            .font(.subheadline)
                    }
                }
                .navigationTitle("Users")
            }
        }
        .onAppear {
            viewModel.fetchData()
        }
    }
}
>>>>>>> main
