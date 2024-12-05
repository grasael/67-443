//
//  CustomReportView.swift
//  rently
//
//  Created by Grace Liao on 11/28/24.
//

import Foundation
import SwiftUI

struct CustomReportView: View {
    @State private var additionalDetails: String = ""
    @Environment(\.presentationMode) var presentationMode

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

            VStack(alignment: .leading, spacing: 8) {
                Text("something else")
                    .font(.headline)
                    .fontWeight(.semibold)
            }
            .frame(maxWidth: .infinity, alignment: .leading)
            .padding(.horizontal)

            VStack(alignment: .leading) {
                ZStack(alignment: .topLeading) {
                    RoundedRectangle(cornerRadius: 8)
                        .stroke(Color.gray.opacity(0.5), lineWidth: 1)
                        .frame(height: 150)

                    if additionalDetails.isEmpty {
                        Text("please tell us why you're reporting this item")
                            .foregroundColor(.pink)
                            .font(.subheadline)
                            .padding(.top, 8)
                            .padding(.horizontal, 8)
                    }

                    TextEditor(text: $additionalDetails)
                        .padding(8)
                        .frame(height: 150)
                        .background(Color.clear)
                        .opacity(1)
                }
            }
            .padding(.horizontal)

            Spacer()

            Button(action: {
                print("Send button tapped with details: \(additionalDetails)")
            }) {
                Text("send")
                    .font(.system(size: 16, weight: .semibold))
                    .foregroundColor(.white)
                    .padding()
                    .frame(maxWidth: .infinity)
            }
            .background(
                LinearGradient(gradient: Gradient(colors: [Color.blue.opacity(0.6), Color.green.opacity(0.6)]),
                               startPoint: .leading,
                               endPoint: .trailing)
            )
            .cornerRadius(8)
            .padding(.horizontal)
            .padding(.bottom)
        }
        .navigationBarHidden(true)
        .background(Color(UIColor.systemBackground))
    }
}

struct CustomReportView_Previews: PreviewProvider {
    static var previews: some View {
        NavigationView {
            CustomReportView()
        }
    }
}

