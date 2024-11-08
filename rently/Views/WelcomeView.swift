//
//  WelcomeView.swift
//  rently
//
//  Created by Grace Liao on 11/7/24.
//
import SwiftUI

struct WelcomeView: View {
    var body: some View {
        NavigationView {
            VStack {
                Spacer()
                
                Text("rently")
                    .font(.system(size: 50, weight: .bold))
                    .foregroundColor(Color(white: 0.9))
                    .shadow(color: .black.opacity(0.5), radius: 5, x: 0, y: 3)
                
                Spacer()
                
                NavigationLink(destination: OnboardingView(onboardingComplete: { user in
                    print("Onboarding complete with user: \(user)")
                })) {
                    Text("get started")
                        .font(.system(size: 18, weight: .semibold))
                        .padding()
                        .frame(maxWidth: .infinity)
                        .background(
                            LinearGradient(gradient: Gradient(colors: [Color.green.opacity(0.7), Color.blue.opacity(0.7)]), startPoint: .leading, endPoint: .trailing)
                        )
                        .foregroundColor(.white)
                        .cornerRadius(12)
                        .padding(.horizontal, 40)
                        .shadow(color: .black.opacity(0.2), radius: 5, x: 0, y: 3)
                }
                
                NavigationLink(destination: SignInView()) {
                    Text("I already have an account")
                        .font(.system(size: 14))
                        .foregroundColor(.gray)
                        .padding(.top, 20)
                }
                
                Spacer()
                    .frame(height: 50)
            }
            .background(
                LinearGradient(gradient: Gradient(colors: [Color.white.opacity(0.8), Color.green.opacity(0.2)]), startPoint: .top, endPoint: .bottom)
            )
            .edgesIgnoringSafeArea(.all)
        }
    }
}

struct WelcomeView_Previews: PreviewProvider {
    static var previews: some View {
        WelcomeView()
    }
}
