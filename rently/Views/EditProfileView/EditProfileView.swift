//
//  EditProfileView.swift
//  rently
//
//  Created by Grace Liao on 11/21/24.
//

import SwiftUI
import FirebaseStorage

struct EditProfileView: View {
    @ObservedObject var userViewModel: UserViewModel
    @State private var isShowingImagePicker = false
    @State private var profileImage: UIImage?
    @State private var showSaveAlert = false
    var onSave: (() -> Void)?
    
    var body: some View {
        NavigationView {
            VStack(spacing: 20) {
                // Profile Image Section
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
                        Text("name")
                            .frame(width: 100, alignment: .leading)
                        TextField("name", text: $userViewModel.user.firstName)
                            .textFieldStyle(RoundedBorderTextFieldStyle())
                    }

                    HStack {
                        Text("username")
                            .frame(width: 100, alignment: .leading)
                        TextField("username", text: $userViewModel.user.username)
                            .textFieldStyle(RoundedBorderTextFieldStyle())
                    }

                    HStack {
                        Text("pronouns")
                            .frame(width: 100, alignment: .leading)
                        TextField("pronouns", text: $userViewModel.user.pronouns)
                            .textFieldStyle(RoundedBorderTextFieldStyle())
                    }

                    HStack {
                        Text("school")
                            .frame(width: 100, alignment: .leading)
                        TextField("school", text: $userViewModel.user.university)
                            .textFieldStyle(RoundedBorderTextFieldStyle())
                    }
                }
                .padding(.horizontal)

                Spacer()

                Button(action: {
                    saveChanges()
                }) {
                    Text("Save Changes")
                        .font(.headline)
                        .foregroundColor(.white)
                        .frame(maxWidth: .infinity)
                        .padding()
                        .background(Color.blue)
                        .cornerRadius(8)
                }
                .alert(isPresented: $showSaveAlert) {
                    Alert(title: Text("Profile Updated"), message: Text("Your profile information has been saved successfully."), dismissButton: .default(Text("OK")))
                }

                Spacer()
            }
            .padding()
            .navigationTitle("Edit Profile")
        }
        .onAppear {
            fetchProfileImage()
        }
    }

    // MARK: - Fetch Profile Image
    private func fetchProfileImage() {
        userViewModel.fetchProfileImageFromStorage { result in
            switch result {
            case .success(let image):
                DispatchQueue.main.async {
                    self.profileImage = image
                }
            case .failure(let error):
                print("Error fetching profile image: \(error)")
            }
        }
    }

    // MARK: - Save Changes
    private func saveChanges() {
        if let profileImage = profileImage {
            userViewModel.saveProfileImageToStorage(profileImage: profileImage) { result in
                switch result {
                case .success:
                    print("Profile image saved successfully.")
                    // Notify parent view if needed
                    showSaveAlert = true
                    onSave?()
                case .failure(let error):
                    print("Error saving profile image: \(error)")
                }
            }
        }

        // Save other user details
        userViewModel.updateUser()
    }

}
