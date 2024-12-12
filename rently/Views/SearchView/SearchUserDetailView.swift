//
//  SearchUserDetailView.swift
//  rently
//
//  Created by Grace Liao on 12/5/24.
//

import Foundation
import SwiftUI

struct SearchUserDetailView: View {
    var user: User
    @ObservedObject var userViewModel: UserViewModel
    @State private var selectedTab = 0 // 0 for Listings, 1 for Likes

    var body: some View {
        ScrollView {
            VStack {
                // Header Section
                HStack {
                    Spacer()
                    Image(systemName: "person.circle.fill")
                        .resizable()
                        .frame(width: 80, height: 80)
                        .foregroundColor(.gray)
                    Spacer()
                }
                .padding(.top)

                Text("\(user.firstName.capitalized) \(user.lastName.capitalized)")
                    .font(.title2)
                    .fontWeight(.bold)
                    .padding(.top, 8)

                HStack(spacing: 4) {
                    Text("\(user.rating, specifier: "%.1f")")
                    Image(systemName: "star.fill")
                        .foregroundColor(.yellow)
                }
                .font(.subheadline)
                .foregroundColor(.secondary)

                // Followers, Following, Rented
                HStack(spacing: 16) {
                    Text("\(user.followers.count) followers")
                        .foregroundColor(.blue)
                    Text("\(user.following.count) following")
                        .foregroundColor(.blue)
                    Text("\(user.renting.count) rented")
                        .foregroundColor(.secondary)
                }
                .font(.subheadline)
                .padding(.top, 8)

                // University and Follow Button
                HStack(spacing: 8) {
                    Image(systemName: "graduationcap.fill")
                        .foregroundColor(.gray)
                    Text(user.university)
                        .foregroundColor(.gray)
                        .font(.subheadline)

                    Spacer()

                    Button(action: {
                        if let userID = user.id {
                            if userViewModel.user.following.contains(userID) {
                                userViewModel.unfollowUser(userID: userID)
                            } else {
                                userViewModel.followUser(userID: userID)
                            }
                        }
                    }) {
                        Text(userViewModel.user.following.contains(user.id ?? "") ? "Unfollow" : "Follow")
                            .font(.system(size: 16, weight: .medium))
                            .foregroundColor(.white)
                            .padding(.horizontal, 24)
                            .padding(.vertical, 8)
                            .background(
                                Group {
                                    if userViewModel.user.following.contains(user.id ?? "") {
                                        Color.red
                                    } else {
                                        LinearGradient(
                                            gradient: Gradient(colors: [Color("MediumBlue"), Color("MediumGreen")]),
                                            startPoint: .leading,
                                            endPoint: .trailing
                                        )
                                    }
                                }
                            )
                            .cornerRadius(20)
                            .shadow(radius: 2)

                    }
                }
                .padding(.top, 8)

                Divider()
                    .padding(.vertical)

                // Listings and Likes Section
                Picker("", selection: $selectedTab) {
                    Text("Listings (\(user.listings.count))").tag(0)
                    Text("Likes").tag(1)
                }
                .pickerStyle(SegmentedPickerStyle())
                .padding(.horizontal)

                if selectedTab == 0 {
                    // Listings Section
                    VStack(spacing: 12) {
                        if user.listings.isEmpty {
                            Text("No listings available.")
                                .foregroundColor(.gray)
                                .font(.subheadline)
                        } else {
                            ForEach(user.listings, id: \.self) { listingID in
                                HStack {
                                    Text("Listing ID: \(listingID)") // Replace with actual listing details
                                        .font(.body)
                                    Spacer()
                                }
                                .padding()
                                .background(Color.gray.opacity(0.1))
                                .cornerRadius(10)
                                .padding(.horizontal)
                            }
                        }
                    }
                } else {
                    // Likes Section Placeholder
                    VStack(spacing: 12) {
                        Text("No likes yet.")
                            .foregroundColor(.gray)
                            .font(.subheadline)
                    }
                }

                Spacer()
            }
            .padding(.horizontal)
        }
        .navigationTitle("\(user.firstName.capitalized)'s Profile")
    }
}
