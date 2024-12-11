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
    @State private var navigateToAppView = false

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
                                gradient: Gradient(colors: [Color("MediumBlue"), Color("LightGreen")]),
                                startPoint: .leading,
                                endPoint: .trailing
                            )
                        )
                        .cornerRadius(20)
                        .padding(.horizontal, 50)
                }
                .padding(.bottom, 10)

                NavigationLink(destination: SignInView(userViewModel: userViewModel, navigateToAppView: $navigateToAppView)) {
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
                  gradient: Gradient(colors: [Color("MediumBlue"), Color("Yellow")]),
                    startPoint: .top,
                    endPoint: .bottom
                )
                .ignoresSafeArea()
            )
            .fullScreenCover(isPresented: $navigateToAppView) {
                AppView(viewModel: userViewModel)
            }
        }
        .navigationBarHidden(true)
    }
}
