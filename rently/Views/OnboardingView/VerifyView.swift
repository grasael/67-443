//
//  VerifyView.swift
//  rently
//
//  Created by Grace Liao on 11/27/24.
//

import Foundation
import SwiftUI

struct VerifyView: View {
    @ObservedObject var userViewModel: UserViewModel

    @State private var selectedInstitution = "Carnegie Mellon University"
    @State private var studentEmail = ""
    @State private var institutions = ["University of Pittsburgh", "Carnegie Mellon University", "Carlow University", "Duquesne University", "Chatham University"]

    var body: some View {
        VStack(spacing: 10) {
            Text("rently is for college campuses!")
                .font(.title)
                .fontWeight(.bold)
                .multilineTextAlignment(.center)
                .fixedSize(horizontal: false, vertical: true)
                .padding(.top, 20)
          
            Image("college_campuses")
              .resizable()
              .scaledToFit()
              .frame(width: 250, height: 250)

            VStack(alignment: .leading, spacing: 4) {
                Text("to join your school's community, please verify your student status.")
                    .font(.subheadline)
                    .multilineTextAlignment(.center)
                    .padding(.horizontal)
                    .padding(.vertical, 20)
                    .fixedSize(horizontal: false, vertical: true)
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
                    .autocapitalization(.none) // Prevent automatic capitalization on the keyboard
                    .onChange(of: studentEmail) { newValue in
                        studentEmail = newValue.lowercased() // Convert to lowercase
                    }
            }
            .padding(.horizontal)

            Spacer()

            HStack {
                NavigationLink(destination: WelcomeView(userViewModel: userViewModel)) {
                    Text("back")
                        .font(.system(size: 16))
                        .fontWeight(.semibold)
                        .padding()
                        .frame(maxWidth: .infinity)
                        .foregroundColor(Color.black)
                        .background(
                            RoundedRectangle(cornerRadius: 20)
                                .stroke(Color.white, lineWidth: 1)
                        )
                }
                NavigationLink(
                    destination: LoadingView(
                        email: studentEmail,
                        university: selectedInstitution,
                        userViewModel: userViewModel
                    )
                ) {
                    Text("next")
                        .font(.system(size: 16))
                        .fontWeight(.semibold)
                        .padding()
                        .frame(maxWidth: .infinity)
                        .foregroundColor(Color.white)
                        .background(
                            LinearGradient(
                              gradient: Gradient(colors: [Color("LightBlue"), Color("LightGreen")]),
                                startPoint: .leading,
                                endPoint: .trailing
                            )
                        )
                        .cornerRadius(20)
                        .shadow(radius: 2)
                }
            }
            .padding(.horizontal)

            Spacer()
        }
        .background(
            LinearGradient(
                gradient: Gradient(colors: [Color("Yellow"), Color("MediumBlue")]),
                startPoint: .top,
                endPoint: .bottom
            )
            .ignoresSafeArea()
        )
        .navigationBarHidden(true)
    }
}
