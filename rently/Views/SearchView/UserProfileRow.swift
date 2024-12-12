//
//  UserProfileRow.swift
//  rently
//
//  Created by Sara Riyad on 11/7/24.
//

import Foundation
import SwiftUI

struct UserProfileRow: View {
    var user: User

    var body: some View {
        HStack {
            // Profile Picture
            Image(systemName: "person.circle.fill")
                .resizable()
                .frame(width: 50, height: 50)
                .foregroundColor(.gray)

            // User Information
            VStack(alignment: .leading) {
                Text("\(user.firstName) \(user.lastName)")
                    .font(.headline)
                Text("@\(user.username)")
                    .font(.subheadline)
                    .foregroundColor(.gray)
            }
            Spacer()

            // Rating
            HStack(spacing: 2) {
                Text("\(user.rating, specifier: "%.1f")")
                Image(systemName: "star.fill")
                    .foregroundColor(.yellow)
                    .font(.caption)
            }
        }
        .padding()
        .background(Color(UIColor.systemGray6))
        .cornerRadius(10)
        .shadow(radius: 1)
    }
}
