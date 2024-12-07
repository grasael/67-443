//
//  VerifiedView.swift
//  rently
//
//  Created by Grace Liao on 11/27/24.
//

import Foundation
import SwiftUI

struct VerifiedView: View {
    @ObservedObject var userViewModel: UserViewModel
    var email: String
    var university: String

    var body: some View {
        VStack(spacing: 20) {
            Text("Student identity verified!")
                .font(.title)
                .padding()

            Spacer()

            NavigationLink(
                destination: OnboardingView(
                    email: email,
                    university: university,
                    userViewModel: userViewModel
                )
            ) {
                Text("Continue to Onboarding")
                    .font(.headline)
                    .foregroundColor(.white)
                    .frame(maxWidth: .infinity)
                    .padding()
                    .background(Color.blue)
                    .cornerRadius(8)
                    .padding(.horizontal)
            }

            Spacer()
        }
        .navigationBarHidden(true)
    }
}
