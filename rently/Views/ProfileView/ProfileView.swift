//
//  ProfileView.swift
//  rently
//
//  Created by Grace Liao on 10/27/24.
//
import SwiftUI
import UIKit
struct ProfileView: View {
    @ObservedObject var userViewModel: UserViewModel
    @StateObject private var listingsViewModel = ListingsViewModel()
    @State private var selectedTab = 0 // 0 for Listings, 1 for Likes
    @State private var profileImage: UIImage?

    var body: some View {
        NavigationView {
            ScrollView {
                VStack {
                    VStack(spacing: 8) {
                        // Profile Picture and Name
                        HStack(spacing: 16) {
                            if let profileImage = profileImage {
                                Image(uiImage: profileImage)
                                    .resizable()
                                    .frame(width: 80, height: 80)
                                    .clipShape(Circle())
                            } else {
                                Image(systemName: "person.circle.fill")
                                    .resizable()
                                    .frame(width: 80, height: 80)
                                    .foregroundColor(.black)
                            }

                            VStack(alignment: .leading, spacing: 4) {
                                Text("\(userViewModel.user.firstName) \(userViewModel.user.lastName)")
                                    .lineLimit(1)
                                    .minimumScaleFactor(0.6)
                                    .font(.title2)
                                    .fontWeight(.bold)
                                    .foregroundColor(.black)

                                NavigationLink(destination: ReviewsView()) {
                                    HStack(spacing: 2) {
                                        Text("\(userViewModel.user.rating, specifier: "%.1f")")
                                            .foregroundColor(.black)
                                        Image(systemName: "star.fill")
                                            .foregroundColor(.yellow)
                                    }
                                }
                            }
                            Spacer()
                            NavigationLink(destination: ProfileSettingsView()
                                .environmentObject(userViewModel)
                                .environmentObject(listingsViewModel)) {
                                Image(systemName: "gearshape.fill")
                                    .font(.title2)
                                    .foregroundColor(.gray)
                            }
                            .padding(.trailing)
                        }
                        .padding(.horizontal)

                        // Stats Section
                        HStack(spacing: 16) {
                            NavigationLink(destination: FollowerView(followerIDs: userViewModel.user.followers, followingIDs: userViewModel.user.following)) {
                                Text("\(userViewModel.user.followers.count) followers")
                                    .font(.subheadline)
                                    .padding(.horizontal, 12)
                                    .padding(.vertical, 6)
                                    .background(
                                        RoundedRectangle(cornerRadius: 15)
                                            .stroke(Color("MediumBlue"), lineWidth: 1)
                                    )
                                    .foregroundColor(.black)
                            }

                            NavigationLink(destination: FollowingView(userViewModel: userViewModel)) {
                                Text("\(userViewModel.user.following.count) following")
                                    .font(.subheadline)
                                    .padding(.horizontal, 12)
                                    .padding(.vertical, 6)
                                    .background(
                                        RoundedRectangle(cornerRadius: 15)
                                            .stroke(Color("MediumBlue"), lineWidth: 1)
                                    )
                                    .foregroundColor(.black)
                            }

                            Text("0 rented")
                                .font(.subheadline)
                                .padding(.horizontal, 12)
                                .padding(.vertical, 6)
                                .background(
                                    RoundedRectangle(cornerRadius: 15)
                                        .stroke(Color("MediumBlue"), lineWidth: 1)
                                )
                                .foregroundColor(.black)
                        }
                        .padding(.top, 8)

                        // University and Edit Profile
                        HStack {
                            Image(systemName: "graduationcap.fill")
                                .foregroundColor(.black)
                            Text(userViewModel.user.university)
                                .font(.footnote)
                                .lineLimit(1)
                                .minimumScaleFactor(0.8)
                                .foregroundColor(.black)
                            Spacer()
                            NavigationLink(destination: EditProfileView(userViewModel: userViewModel)) {
                                HStack {
                                    Image(systemName: "pencil")
                                    Text("edit profile")
                                        .lineLimit(1)
                                        .minimumScaleFactor(0.8)
                                }
                                .font(.subheadline)
                                .foregroundColor(.white)
                                .padding(.horizontal, 16)
                                .padding(.vertical, 8)
                                .background(
                                    LinearGradient(
                                        gradient: Gradient(colors: [Color("LightBlue"), Color("LightGreen")]),
                                        startPoint: .leading,
                                        endPoint: .trailing
                                    )
                                )
                                .cornerRadius(20)
                                .shadow(radius: 2)
                            }
                        }
                        .padding(.horizontal)
                        .padding(.top, 8)
                    }
                    .padding(.top, 40)

                    Divider()

                    // Picker for Listings and Likes
                    Picker("", selection: $selectedTab) {
                        Text("Listings (\(listingsViewModel.listingsCount(for: userViewModel.user.id ?? "")))").tag(0)
                        Text("Likes").tag(1)
                    }
                    .pickerStyle(SegmentedPickerStyle())
                    .padding(.horizontal)

                    // Tab Content
                    if selectedTab == 0 {
                        ListingsProfileView()
                            .environmentObject(listingsViewModel)
                            .environmentObject(userViewModel)
                    } else {
                        LikesView()
                            .environmentObject(userViewModel)
                            .environmentObject(listingsViewModel)
                    }
                }
                .padding()
            }
            .navigationBarTitleDisplayMode(.inline)
            .onAppear {
                userViewModel.fetchProfileImageFromStorage { result in
                    switch result {
                    case .success(let image):
                        DispatchQueue.main.async {
                            self.profileImage = image
                        }
                    case .failure(let error):
                        print("Error fetching profile image: \(error)")
                    }
                }
                listingsViewModel.fetchListings()
            }
        }
    }
}

 
