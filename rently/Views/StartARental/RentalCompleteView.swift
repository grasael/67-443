//
//  RentalCompleteView.swift
//  rently
//
//  Created by Tishyaa Chaudhry on 12/5/24.
//

import Foundation
import SwiftUI
import MessageUI

struct RentalCompleteView: View {
    var itemName: String
    var userEmail: String
    var pickupLocation: String
    var pickupDate: Date

    @State private var isShowingMailView = false
    @State private var mailError: MailError?

    // State to manage navigation
    @State private var navigateToHome = false

    var body: some View {
        VStack(spacing: 24) {
            // Cross button in top corner to go to Home view
            HStack {
                Spacer()
                Button(action: {
                    // Set navigation state to true to navigate to home
                    navigateToHome = true
                }) {
                    Image(systemName: "xmark.circle.fill")
                        .foregroundColor(.gray)
                        .font(.title)
                }
                .padding(.top)
                .padding(.trailing)
            }

            Text("Rental Complete!")
                .font(.largeTitle)
                .fontWeight(.bold)
                .foregroundColor(.blue)

            VStack(alignment: .leading, spacing: 8) {
                Text("Meet at the")
                    .font(.subheadline)
                Text("\(pickupLocation) on \(formattedDate(pickupDate))")
                    .font(.headline)

                Text("Email the owner using the button below to confirm the pickup time and finalize the payment method.")
                    .font(.subheadline)
            }
            .multilineTextAlignment(.leading)
            .padding()

            Button(action: {
                if MFMailComposeViewController.canSendMail() {
                    isShowingMailView = true
                } else {
                    mailError = .cannotSendMail
                }
            }) {
                HStack {
                    Image(systemName: "envelope.fill")
                        .foregroundColor(.white)
                    Text("Email Owner")
                        .foregroundColor(.white)
                        .fontWeight(.bold)
                }
                .foregroundColor(.white)
                .padding(.vertical, 10)
                .padding(.horizontal, 40)
                .font(.system(size: 16, weight: .semibold))
                .background(
                    LinearGradient(
                        gradient: Gradient(colors: [Color("MediumBlue"), Color("MediumGreen")]),
                        startPoint: .leading,
                        endPoint: .trailing
                    )
                )
                .cornerRadius(20)
            }

            Spacer()

            Image(systemName: "rocket.fill")
                .resizable()
                .aspectRatio(contentMode: .fit)
                .frame(height: 150)
                .foregroundColor(.blue)

            Text("Thank you for renting with")
                .font(.footnote)
                .foregroundColor(.secondary)
            Text("Rently")
                .font(.title3)
                .fontWeight(.bold)
                .foregroundColor(.blue)
        }
        .padding()
        .sheet(isPresented: $isShowingMailView) {
            MailComposeView(
                recipient: userEmail,
                subject: "Rental Request for \(itemName)"
            )
        }
        .alert(item: $mailError) { error in
            Alert(title: Text("Error"), message: Text(error.localizedDescription), dismissButton: .default(Text("OK")))
        }
        .navigationBarHidden(true)
        .navigationBarBackButtonHidden(true)
        .background(
            NavigationLink(destination: HomeView(), isActive: $navigateToHome) {
                EmptyView()
            }
        )
    }

    private func formattedDate(_ date: Date) -> String {
        let formatter = DateFormatter()
        formatter.dateStyle = .medium
        return formatter.string(from: date)
    }
}

enum MailError: Identifiable, LocalizedError {
    case cannotSendMail

    var id: String { localizedDescription }

    var errorDescription: String? {
        switch self {
        case .cannotSendMail:
            return "Mail services are not available. Please set up a mail account in your device settings."
        }
    }
}

struct RentalCompleteView_Preview: PreviewProvider {
    static var previews: some View {
        RentalCompleteView(
            itemName: "Jacket",
            userEmail: "owner@example.com",
            pickupLocation: "UC",
            pickupDate: Date()
        )
    }
}
