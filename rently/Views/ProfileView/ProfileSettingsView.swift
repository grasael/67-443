// ProfileSettingsView.swift
//  rently
//
//  Created by Grace Liao on 12/12/24.
//
import SwiftUI

struct ProfileSettingsView: View {
    @EnvironmentObject var userViewModel: UserViewModel
    @Environment(\.presentationMode) var presentationMode
    @State private var showWelcomeView = false // To navigate back to WelcomeView

    var body: some View {
        NavigationView {
            ScrollView {
                VStack(alignment: .leading, spacing: 30) {
                    // My Account Section
                    SectionHeader(title: "my account")
                    
                    VStack(spacing: 15) {
                        NavigationLink(destination: EditProfileView(userViewModel: userViewModel)) {
                            SettingsRow(title: "profile")
                        }
                    }
                    
                    // Renting Section
                    SectionHeader(title: "renting")
                    
                    VStack(spacing: 15) {
                        // Navigate to RentalsView for Renting History
                        NavigationLink(destination: RentalsView()) {
                            SettingsRow(title: "renting history")
                        }
                    }
                    
                    // Support Section
                    SectionHeader(title: "support")
                    
                    VStack(spacing: 15) {
                        NavigationLink(destination: HelpView()) {
                            SettingsRow(title: "help")
                        }
                    }
                    
                    // Logout Button
                    Button(action: handleSignOut) {
                        Text("logout")
                            .foregroundColor(.red)
                            .frame(maxWidth: .infinity, minHeight: 44)
                            .background(Color.white)
                            .cornerRadius(8)
                            .overlay(
                                RoundedRectangle(cornerRadius: 8)
                                    .stroke(Color.red, lineWidth: 1)
                            )
                    }
                    .padding(.horizontal)
                    
                    // Delete Account Button
                    Button(action: handleDeleteAccount) {
                        Text("delete my account")
                            .foregroundColor(.red)
                            .frame(maxWidth: .infinity, minHeight: 44)
                            .background(Color.white)
                            .cornerRadius(8)
                            .overlay(
                                RoundedRectangle(cornerRadius: 8)
                                    .stroke(Color.red, lineWidth: 1)
                            )
                    }
                    .padding(.horizontal)
                }
                .padding(.top)
            }
            .navigationTitle("settings")
            .navigationBarTitleDisplayMode(.inline)
            .fullScreenCover(isPresented: $showWelcomeView) {
                WelcomeView(userViewModel: userViewModel) // Pass the required argument
            }
        }
        .tint(.black)
    }
    
    // MARK: - Handlers
    
    private func handleSignOut() {
        userViewModel.signOut {
            showWelcomeView = true // Navigate back to WelcomeView
        }
    }
    
    private func handleDeleteAccount() {
        userViewModel.deleteUser()
        showWelcomeView = true
    }
}

// MARK: - Subviews

struct SectionHeader: View {
    let title: String
    
    var body: some View {
        Text(title)
            .font(.headline)
            .fontWeight(.semibold)
            .padding(.horizontal)
    }
}

struct SettingsRow: View {
    let title: String
    
    var body: some View {
        HStack {
            Text(title)
                .font(.body)
            Spacer()
            Image(systemName: "chevron.right")
                .foregroundColor(.gray)
        }
        .padding()
        .background(Color.white)
        .cornerRadius(8)
        .overlay(
            RoundedRectangle(cornerRadius: 8)
                .stroke(Color.gray.opacity(0.3), lineWidth: 1)
        )
        .padding(.horizontal)
    }
}
