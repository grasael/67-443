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
                if let userID = user.id {
                    if userViewModel.user.following.contains(userID) {
                        userViewModel.unfollowUser(userID: userID)
                    } else {
                        userViewModel.followUser(userID: userID)
                    }
                }
            }) {
                Text(userViewModel.user.following.contains(user.id ?? "") ? "Unfollow" : "Follow")
                    .font(.headline)
                    .padding()
                    .frame(maxWidth: .infinity)
                    .background(userViewModel.user.following.contains(user.id ?? "") ? Color.red : Color.blue)
                    .foregroundColor(.white)
                    .cornerRadius(10)
            }
            .padding()

            List {
                Section(header: Text("Listings")) {
                    ForEach(user.listings, id: \.self) { listingID in
                        Text(listingID)
                    }
                }
            }

            Spacer()
        }
        .navigationTitle("\(user.firstName)'s Profile")
    }
}
