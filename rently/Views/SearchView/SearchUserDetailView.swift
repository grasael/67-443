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
    @ObservedObject var userManager = UserManager.shared

    var body: some View {
        VStack {
            HStack {
                Text("\(user.firstName) \(user.lastName)")
                    .font(.largeTitle)
                    .fontWeight(.bold)
                Spacer()
            }
            .padding()

            Text("@\(user.username)")
                .foregroundColor(.gray)

            Button(action: {
                guard let userID = user.id else { return }
                if let currentUser = userManager.user {
                    if currentUser.following.contains(userID) {
                        var updatedUser = currentUser
                        updatedUser.following.removeAll { $0 == userID }
                        userManager.saveUser(updatedUser)
                    } else {
                        var updatedUser = currentUser
                        updatedUser.following.append(userID)
                        userManager.saveUser(updatedUser)
                    }
                }
            }) {
                Text(userManager.user?.following.contains(user.id ?? "") == true ? "Unfollow" : "Follow")
                    .font(.headline)
                    .padding()
                    .frame(maxWidth: .infinity)
                    .background(userManager.user?.following.contains(user.id ?? "") == true ? Color.red : Color.blue)
                    .foregroundColor(.white)
                    .cornerRadius(10)
            }
            .padding()

            List {
                Section(header: Text("Listings")) {
                    ForEach(user.listings, id: \ .self) { listingID in
                        Text(listingID)
                    }
                }
            }

            Spacer()
        }
        .navigationTitle("\(user.firstName)'s Profile")
    }
}
