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
            Text("student identity verified!")
                .font(.title)
                .padding()

            Spacer()
          
            Image("student_identity")
              .resizable()
              .scaledToFit()
              .frame(width: 350, height: 350)
              .padding()
          
            Spacer()

            NavigationLink(
                destination: OnboardingView(
                    email: email,
                    university: university,
                    userViewModel: userViewModel
                )
            ) {
                Text("continue to onboarding")
                    .font(.headline)
                    .foregroundColor(.white)
                    .frame(maxWidth: .infinity)
                    .padding()
                    .background(
                        LinearGradient(
                            gradient: Gradient(colors: [Color("MediumBlue"), Color("LightGreen")]),
                            startPoint: .leading,
                            endPoint: .trailing
                        )
                    )
                    .cornerRadius(20)
                    .padding(.horizontal)
            }

            Spacer()
        }
        .background(
            LinearGradient(
                gradient: Gradient(colors: [Color("LightBlue"), Color("Yellow")]),
                startPoint: .top,
                endPoint: .bottom
            )
            .ignoresSafeArea()
        )
        .navigationBarHidden(true)
    }
}
