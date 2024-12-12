//
//  FollowingView.swift
//  rently
//
//  Created by Grace Liao on 12/1/24.
//

import SwiftUI

import SwiftUI

struct FollowingView: View {
    @ObservedObject var userViewModel: UserViewModel
    @State private var followingUsers: [User] = []
    @State private var isLoading = true

    var body: some View {
        VStack {
            if isLoading {
                ProgressView("Loading...")
                    .padding()
            } else if followingUsers.isEmpty {
                Text("You are not following anyone yet.")
                    .font(.headline)
                    .foregroundColor(.gray)
                    .padding()
            } else {
                List {
                    ForEach(followingUsers) { user in
                        HStack {
                            NavigationLink(destination: SearchUserDetailView(user: user, userViewModel: userViewModel)) {
                                HStack {
                                    Image(systemName: "person.circle.fill")
                                        .resizable()
                                        .frame(width: 40, height: 40)
                                        .foregroundColor(.gray)

                                    VStack(alignment: .leading) {
                                        Text(user.firstName + " " + user.lastName)
                                            .font(.headline)
                                        Text("@\(user.username)")
                                            .font(.subheadline)
                                            .foregroundColor(.gray)
                                    }
                                }
                            }
                            .buttonStyle(PlainButtonStyle()) // Prevent NavigationLink from interfering with the button

                            Spacer()

                            Button(action: {
                                unfollow(user: user)
                            }) {
                                Text("following")
                                    .font(.system(size: 14))
                                    .fontWeight(.semibold)
                                    .foregroundColor(.white)
                                    .padding(.horizontal, 12)
                                    .padding(.vertical, 6)
                                    .background(Color.blue)
                                    .cornerRadius(20)
                            }
                            .buttonStyle(BorderlessButtonStyle()) // Ensure the button handles its own tap
                        }
                        .padding(.vertical, 8)
                    }
                }
                .listStyle(PlainListStyle())
            }
        }
        .navigationTitle("Following")
        .onAppear {
            fetchFollowingUsers()
        }
    }

    private func fetchFollowingUsers() {
        isLoading = true
        userViewModel.fetchFollowingUsers { users in
            self.followingUsers = users
            self.isLoading = false
        }
    }

    private func unfollow(user: User) {
        print("Unfollowing \(user.username)")
        userViewModel.unfollowUser(userID: user.id ?? "")
        followingUsers.removeAll { $0.id == user.id }
    }
}
