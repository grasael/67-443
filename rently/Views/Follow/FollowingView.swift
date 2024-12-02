//
//  FollowingView.swift
//  rently
//
//  Created by Grace Liao on 12/1/24.
//

import SwiftUI

struct FollowingView: View {
    @State private var followingUsers: [User]

    init(followingUsers: [User]) {
        _followingUsers = State(initialValue: followingUsers)
    }

    var body: some View {
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
        .navigationTitle("following")
    }

    private func unfollow(user: User) {
        print("Unfollowing \(user.username)")

        // Remove the user from the followingUsers array
        followingUsers.removeAll { $0.id == user.id }
    }
}

struct FollowingView_Previews: PreviewProvider {
    static var previews: some View {
        NavigationView {
            FollowingView(followingUsers: mockUsers())
        }
    }
}

// Mock Data for Preview
func mockUsers() -> [User] {
    return [
        User(id: "1", firstName: "Kai", lastName: "", username: "kaicmu", pronouns: "he/him", email: "kai@test.com", password: "password", university: "CMU", rating: 5.0, listings: [], likedItems: [], styleChoices: [], events: [], followers: [], following: []),
        User(id: "2", firstName: "Lena", lastName: "Smith", username: "fearreal", pronouns: "she/her", email: "lena@test.com", password: "password", university: "CMU", rating: 4.5, listings: [], likedItems: [], styleChoices: [], events: [], followers: [], following: []),
    ]
}
