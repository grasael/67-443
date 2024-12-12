//
//  DislikeReportView.swift
//  rently
//
//  Created by Grace Liao on 11/28/24.
//

import Foundation
import SwiftUI

struct DislikeReportView: View {
    //var username: String
    @Environment(\.presentationMode) var presentationMode
    @State private var showAcknowledgmentPopup = false

    var body: some View {
        VStack(spacing: 20) {
            HStack {
                Button(action: {
                    presentationMode.wrappedValue.dismiss()
                }) {
                    Image(systemName: "chevron.left")
                        .foregroundColor(.black)
                }
                Spacer()
                Text("report")
                    .font(.title2)
                    .fontWeight(.bold)
                Spacer()
                Spacer()
            }
            .padding([.horizontal, .top])

            VStack(spacing: 16) {
                Text("would you like to block this user?")
                    .font(.headline)
                    .multilineTextAlignment(.center)

                Image(systemName: "person.circle")
                    .resizable()
                    .scaledToFit()
                    .frame(width: 100, height: 100)
                    .foregroundColor(.black)

                Text("username")
                    .font(.headline)
                    .fontWeight(.semibold)
            }
            .padding()

            Text("they won’t be able to contact you and you won’t see any of their listings. we won’t tell them that you’ve blocked them.")
                .font(.subheadline)
                .foregroundColor(.gray)
                .multilineTextAlignment(.center)
                .padding(.horizontal)

            Spacer()

            VStack(spacing: 12) {
                Button(action: {
                    print("Username is blocked.")
                }) {
                    Text("block")
                    //action to block goes here ?
                        .font(.system(size: 16, weight: .semibold))
                        .foregroundColor(.white)
                        .padding()
                        .frame(maxWidth: .infinity)
                }
                .background(
                    LinearGradient(
                        gradient: Gradient(colors: [Color.blue.opacity(0.6), Color.green.opacity(0.6)]),
                        startPoint: .leading,
                        endPoint: .trailing
                    )
                )
                .cornerRadius(8)
                .padding(.horizontal)

                Button(action: {
                    presentationMode.wrappedValue.dismiss()
                }) {
                    Text("close")
                    // action: would take them back to home
                        .font(.system(size: 16, weight: .semibold))
                        .foregroundColor(.black)
                        .padding()
                        .frame(maxWidth: .infinity)
                        .overlay(
                            RoundedRectangle(cornerRadius: 8)
                                .stroke(
                                    LinearGradient(
                                        gradient: Gradient(colors: [Color.blue.opacity(0.6), Color.green.opacity(0.6)]),
                                        startPoint: .leading,
                                        endPoint: .trailing
                                    ),
                                    lineWidth: 1
                                )
                        )
                }
                .padding(.horizontal)
            }
            .padding(.bottom)
        }
        .navigationBarHidden(true)
        .background(Color(UIColor.systemBackground))
    }
}

struct DislikeReportView_Previews: PreviewProvider {
    static var previews: some View {
        DislikeReportView()
    }
}
