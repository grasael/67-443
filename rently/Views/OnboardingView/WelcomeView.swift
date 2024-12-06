//
//  WelcomeView.swift
//  rently
//
//  Created by Grace Liao on 11/27/24.
//

import Foundation
import SwiftUI

struct WelcomeView: View {
    @ObservedObject var userViewModel: UserViewModel

    var body: some View {
        NavigationView {
            VStack {
                Spacer()

                Text("rently")
                    .font(.system(size: 60, weight: .bold))
                    .foregroundColor(Color.blue.opacity(0.8))
                    .shadow(radius: 2)
                    .padding()

                Spacer()

                NavigationLink(destination: VerifyView(userViewModel: userViewModel)) {
                    Text("get started")
                        .font(.headline)
                        .foregroundColor(.white)
                        .frame(maxWidth: .infinity)
                        .padding()
                        .background(
                            LinearGradient(
                                gradient: Gradient(colors: [Color.blue.opacity(0.4), Color.green.opacity(0.8)]),
                                startPoint: .leading,
                                endPoint: .trailing
                            )
                        )
                        .cornerRadius(20)
                        .padding(.horizontal, 50)
                }
                .padding(.bottom, 10)

                NavigationLink(destination: SignInView()) {
                    Text("I already have an account")
                        .font(.subheadline)
                        .foregroundColor(.black)
                        .underline()
                }
                .padding(.bottom, 40)

                Spacer()
            }
            .background(
                LinearGradient(
                    gradient: Gradient(colors: [Color(red: 0.9, green: 0.95, blue: 1), Color.white]),
                    startPoint: .top,
                    endPoint: .bottom
                )
                .ignoresSafeArea()
            )
        }
        .navigationBarHidden(true)
    }
}
