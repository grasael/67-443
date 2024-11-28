//
//  VerifyView.swift
//  rently
//
//  Created by Grace Liao on 11/27/24.
//

import Foundation
import SwiftUI

struct VerifyView: View {
    @State private var selectedInstitution = ""
    @State private var studentEmail = ""
    @State private var institutions = ["University of Pittsburgh", "Carnegie Mellon University"]

    var body: some View {
        VStack(spacing: 20) {
            Text("rently is for college campuses!")
                .font(.title)
                .fontWeight(.bold)
                .multilineTextAlignment(.center)
                .padding(.top, 40)
            
            Spacer()
            Spacer()
            Spacer()

            VStack(alignment: .leading, spacing: 4) {
                Text("to join your school's community, please verify your student status.")
                    .font(.subheadline)
                    .multilineTextAlignment(.center)
                    .padding(.horizontal)
                    .padding(.vertical, 20)
                    .foregroundColor(.black)
            
                
                Text("select your institution:")
                    .font(.system(size: 14))
                    .fontWeight(.semibold)
                    .foregroundColor(.black)

                Picker("Select Institution", selection: $selectedInstitution) {
                    ForEach(institutions, id: \.self) { institution in
                        Text(institution)
                    }
                }
                .pickerStyle(MenuPickerStyle())
                .frame(maxWidth: .infinity, minHeight: 44)
                .background(Color.white)
                .cornerRadius(8)
                .overlay(
                    RoundedRectangle(cornerRadius: 8)
                        .stroke(Color.gray, lineWidth: 1)
                )
            }
            .padding(.horizontal)

            VStack(alignment: .leading, spacing: 4) {
                Text("enter student email:")
                    .font(.system(size: 14))
                    .fontWeight(.semibold)
                    .foregroundColor(.black)

                TextField("", text: $studentEmail)
                    .padding(8)
                    .font(.system(size: 14))
                    .background(Color.white)
                    .cornerRadius(8)
                    .overlay(
                        RoundedRectangle(cornerRadius: 8)
                            .stroke(Color.gray, lineWidth: 1)
                    )
            }
            .padding(.horizontal)

            Spacer()

            HStack {
                NavigationLink(destination: WelcomeView()) {
                    Text("back")
                        .font(.system(size: 16))
                        .fontWeight(.semibold)
                        .padding()
                        .frame(maxWidth: .infinity)
                        .foregroundColor(Color.black)
                        .background(
                            RoundedRectangle(cornerRadius: 20)
                                .stroke(Color.gray, lineWidth: 1)
                        )
                }

                NavigationLink(destination: ListView()) {
                    Text("next")
                        .font(.system(size: 16))
                        .fontWeight(.semibold)
                        .padding()
                        .frame(maxWidth: .infinity)
                        .foregroundColor(Color.white)
                        .background(
                            LinearGradient(
                                gradient: Gradient(colors: [Color.blue.opacity(0.6), Color.green.opacity(0.6)]),
                                startPoint: .leading,
                                endPoint: .trailing
                            )
                        )
                        .cornerRadius(20)
                }
            }
            .padding(.horizontal)


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
        .navigationBarHidden(true)
    }
}

struct VerifyView_Previews: PreviewProvider {
    static var previews: some View {
        VerifyView()
    }
}
