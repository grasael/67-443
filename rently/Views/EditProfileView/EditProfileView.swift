//
//  EditProfileView.swift
//  rently
//
//  Created by Grace Liao on 11/21/24.
//

import SwiftUI

struct EditProfileView: View {
    @ObservedObject var userViewModel: UserViewModel
    @State private var isShowingImagePicker = false
    @State private var profileImage: UIImage?

    var body: some View {
        NavigationView {
            VStack(spacing: 20) {
                Button(action: {
                    isShowingImagePicker.toggle()
                }) {
                    if let profileImage = profileImage {
                        Image(uiImage: profileImage)
                            .resizable()
                            .scaledToFill()
                            .frame(width: 100, height: 100)
                            .clipShape(Circle())
                            .overlay(
                                Circle()
                                    .stroke(Color.gray, lineWidth: 2)
                            )
                    } else {
                        Image(systemName: "person.crop.circle.fill")
                            .resizable()
                            .scaledToFill()
                            .frame(width: 100, height: 100)
                            .foregroundColor(.gray)
                            .overlay(
                                Circle()
                                    .stroke(Color.gray, lineWidth: 2)
                            )
                    }
                }
                .sheet(isPresented: $isShowingImagePicker) {
                    ImagePicker(image: $profileImage)
                }

                Text("edit picture")
                    .font(.subheadline)
                    .foregroundColor(.blue)

                VStack(spacing: 12) {
                    HStack {
                        Text("Name")
                            .frame(width: 100, alignment: .leading)
                        TextField("Name", text: $userViewModel.user.firstName)
                            .textFieldStyle(RoundedBorderTextFieldStyle())
                    }

                    HStack {
                        Text("Username")
                            .frame(width: 100, alignment: .leading)
                        TextField("Username", text: $userViewModel.user.username)
                            .textFieldStyle(RoundedBorderTextFieldStyle())
                    }

                    HStack {
                        Text("Pronouns")
                            .frame(width: 100, alignment: .leading)
                        Picker("Pronouns", selection: $userViewModel.user.pronouns) {
                            Text("She/Her").tag("She/Her")
                            Text("He/Him").tag("He/Him")
                            Text("They/Them").tag("They/Them")
                            Text("Other").tag("Other")
                        }
                        .pickerStyle(MenuPickerStyle())
                    }

                    HStack {
                        Text("School")
                            .frame(width: 100, alignment: .leading)
                        TextField("School", text: $userViewModel.user.university)
                            .textFieldStyle(RoundedBorderTextFieldStyle())
                    }
                }
                .padding(.horizontal)

                Spacer()

                Button(action: {
                    userViewModel.updateUser()
                }) {
                    Text("Save Changes")
                        .font(.headline)
                        .foregroundColor(.white)
                        .frame(maxWidth: .infinity)
                        .padding()
                        .background(Color.blue)
                        .cornerRadius(8)
                }

                Button(action: {
                    // Add logic for deleting the account
                }) {
                    Text("Delete Account")
                        .font(.headline)
                        .foregroundColor(.red)
                }
                .padding(.top, 20)

                Spacer()
            }
            .padding()
            .navigationTitle("Edit Profile")
        }
    }
}
