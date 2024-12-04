//
//  VerifiedView.swift
//  rently
//
//  Created by Grace Liao on 11/27/24.
//

import Foundation
import SwiftUI

struct VerifiedView: View {
    var onboardingComplete: (User) -> Void
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
                    onboardingComplete: onboardingComplete,
                    email: email,
                    university: university
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

struct VerifiedView_Previews: PreviewProvider {
    static var previews: some View {
        VerifiedView(
            onboardingComplete: { _ in },
            email: "test@example.com",
            university: "Test University"
        )
    }
}
