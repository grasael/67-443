//
//  ProfileView.swift
//  rently
//
//  Created by Grace Liao on 10/27/24.
//
import SwiftUI

struct ProfileView: View {
    @ObservedObject var userViewModel: UserViewModel

    @StateObject private var listingsViewModel = ListingsViewModel()
    @State private var selectedTab = 0 // 0 for Listings, 1 for Likes

  var body: some View {
      NavigationView {
        ScrollView {
          VStack(spacing: 16) {
            // Profile Header
            ZStack(alignment: .topTrailing) {
                // Gradient Background Image
                Image("profile-gradient")
                    .resizable()
                    .scaledToFill()
                    .ignoresSafeArea()

                VStack(spacing: 8) {
                    // Profile Picture and Name
                    HStack(spacing: 16) {
                        Image(systemName: "person.circle.fill")
                            .resizable()
                            .frame(width: 80, height: 80)
                            .foregroundColor(.black)

                        VStack(alignment: .leading, spacing: 4) {
                            Text("\(userViewModel.user.firstName) \(userViewModel.user.lastName)")
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
                        Image(systemName: "gearshape")
                            .font(.title2)
                            .foregroundColor(.black)
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
            }

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

            Spacer()
          }
          .padding()
      }
      .navigationBarTitleDisplayMode(.inline)
      .onAppear {
          listingsViewModel.fetchListings()
      }
    }
  }
}

// MARK: - Preview Data
struct ProfilePreviewData {
    static let mockUser = User(
        id: "12345",
        firstName: "Amelia",
        lastName: "Bose",
        username: "amelia123",
        pronouns: "she/her",
        email: "amelia@example.com",
        password: "password123", // Use a placeholder for security
        university: "Carnegie Mellon University",
        rating: 5.0,
        listings: [],
        likedItems: [],
        styleChoices: ["formal", "casual"],
        events: ["party", "conference"],
        followers: ["user1", "user2"],
        following: ["user3", "user4"],
        renting: ["item1", "item2"],
        myItems: ["item3", "item4"]
    )
}

// MARK: - Preview Provider
struct ProfileView_Previews: PreviewProvider {
    static var previews: some View {
        ProfileView(userViewModel: UserViewModel(user: ProfilePreviewData.mockUser))
    }
}
