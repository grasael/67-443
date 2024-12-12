//
//  FollowerView.swift
//  rently
//
//  Created by Grace Liao on 12/1/24.
//

import Foundation
import SwiftUI

struct FollowerView: View {
    @State private var followerIDs: [String]
    @State private var followingIDs: [String]

    init(followerIDs: [String], followingIDs: [String]) {
        _followerIDs = State(initialValue: followerIDs)
        _followingIDs = State(initialValue: followingIDs)
    }

    var body: some View {
        VStack {
            if followerIDs.isEmpty {
                Text("You don't have any followers yet.")
                    .font(.headline)
                    .foregroundColor(.gray)
                    .padding()
            } else {
                List(followerIDs, id: \ .self) { id in
                    HStack {
                        NavigationLink(destination: Text("User Profile for \(id)")) { // Replace with actual user profile view
                            HStack {
                                Image(systemName: "person.circle.fill")
                                    .resizable()
                                    .frame(width: 40, height: 40)
                                    .foregroundColor(.gray)

                                VStack(alignment: .leading) {
                                    Text("User ID: \(id)")
                                        .font(.headline)
                                    Text("@username_placeholder")
                                        .font(.subheadline)
                                        .foregroundColor(.gray)
                                }
                            }
                        }

                        Spacer()

                        if followingIDs.contains(id) {
                            Button(action: {
                                unfollow(userID: id)
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
                        } else {
                            Button(action: {
                                follow(userID: id)
                            }) {
                                Text("follow")
                                    .font(.system(size: 14))
                                    .fontWeight(.semibold)
                                    .foregroundColor(.blue)
                                    .padding(.horizontal, 12)
                                    .padding(.vertical, 6)
                                    .overlay(
                                        RoundedRectangle(cornerRadius: 20)
                                            .stroke(Color.blue, lineWidth: 1)
                                    )
                            }
                        }
                    }
                    .padding(.vertical, 8)
                }
                .listStyle(PlainListStyle())
            }
        }
        .navigationTitle("Followers")
    }

    private func follow(userID: String) {
        print("Following user ID \(userID)")
        followingIDs.append(userID)
    }

    private func unfollow(userID: String) {
        print("Unfollowing user ID \(userID)")
        followingIDs.removeAll { $0 == userID }
    }
}


struct FollowerView_Previews: PreviewProvider {
    static var previews: some View {
        NavigationView {
            FollowerView(
                followerIDs: ["1", "2"],
                followingIDs: ["1"]
            )
        }
    }
}
