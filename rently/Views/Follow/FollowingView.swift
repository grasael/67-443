//
//  FollowingView.swift
//  rently
//
//  Created by Grace Liao on 12/1/24.
//

import SwiftUI
import Firebase

struct FollowingView: View {
    @ObservedObject var userManager: UserManager = UserManager.shared
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
        guard let currentUser = userManager.user else {
            self.isLoading = false
            return
        }

        isLoading = true

        let db = Firestore.firestore()
        db.collection("Users")
            .whereField("id", in: currentUser.following)
            .getDocuments { snapshot, error in
                if let error = error {
                    print("Error fetching following users: \(error.localizedDescription)")
                    self.isLoading = false
                    return
                }

                if let documents = snapshot?.documents {
                    self.followingUsers = documents.compactMap { try? $0.data(as: User.self) }
                }
                self.isLoading = false
            }
    }

    private func unfollow(user: User) {
        guard let currentUser = userManager.user else { return }

        print("Unfollowing \(user.username)")

        userManager.user?.following.removeAll { $0 == user.id }
        followingUsers.removeAll { $0.id == user.id }

        userManager.saveUser(currentUser) // Updates Firestore
    }
}
