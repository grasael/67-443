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
            Text(user.firstName + user.lastName)
                .font(.headline)
            Spacer()
            Text(user.username)
                .font(.subheadline)
                .foregroundColor(.gray)
        }
        .padding()
    }
}


