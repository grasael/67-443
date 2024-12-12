//
//  PopupView.swift
//  rently
//
//  Created by Grace Liao on 12/12/24.
//

import SwiftUI
import Foundation

struct PopupView: View {
    let userFirstName: String
    @Binding var showPopup: Bool

    var body: some View {
        ZStack {
            VStack {
                Spacer()
                VStack(spacing: 16) {
                    Text("welcome to rently, \(userFirstName.lowercased().capitalized)!")
                        .font(.headline)
                        .multilineTextAlignment(.center)
                        .padding(.top)

                    Image("1") // Use your custom image
                        .resizable()
                        .scaledToFit()
                        .frame(width: 100, height: 100) // Adjust size as needed

                    Button(action: {
                        // Dismiss the popup when the user clicks "Get Started!"
                        showPopup = false
                    }) {
                        Text("get started!")
                            .font(.headline)
                            .foregroundColor(.white)
                            .padding()
                            .frame(maxWidth: .infinity)
                            .background(
                                LinearGradient(
                                    gradient: Gradient(colors: [Color.blue, Color.green]),
                                    startPoint: .leading,
                                    endPoint: .trailing
                                )
                            )
                            .cornerRadius(10)
                            .padding(.horizontal)
                    }
                }
                .padding()
                .background(Color.white)
                .cornerRadius(20)
                .shadow(radius: 10)
                .padding()
            }
        }
        .animation(.easeInOut) // Optional: smooth fade-in/fade-out animation
    }
}
