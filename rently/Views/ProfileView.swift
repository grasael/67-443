//
//  ProfileView.swift
//  rently
//
//  Created by Grace Liao on 10/27/24.
//

import SwiftUI

struct ProfileView: View {
    let user: User
    @State private var selectedTab = 0 // 0 for Listings, 1 for Likes

    var body: some View {
        NavigationView {
            ScrollView {
                VStack {
                    HStack {
                        Spacer()
                        Image(systemName: "gearshape.fill")
                            .font(.title2)
                            .foregroundColor(.gray)
                    }
                    .padding([.top, .trailing])

                    HStack {
                        Image(systemName: "person.circle.fill")
                            .resizable()
                            .frame(width: 80, height: 80)
                            .foregroundColor(.gray)
                        
                        VStack(alignment: .leading) {
                            Text("\(user.firstName) \(user.lastName)")
                                .font(.title2)
                                .fontWeight(.bold)
                            
                            // Make rating clickable using NavigationLink
                            NavigationLink(destination: ReviewsView()) {
                                HStack(spacing: 2) {
                                    Text("\(user.rating, specifier: "%.1f")")
                                    Image(systemName: "star.fill")
                                        .foregroundColor(.yellow)
                                }
                            }
                            .foregroundColor(.primary)
                        }
                        Spacer()
                    }
                    .padding(.horizontal)
                    
                    HStack(spacing: 16) {
                        Text("90 followers")
                        Text("70 following")
                        Text("10 rented")
                    }
                    .font(.subheadline)
                    .foregroundColor(.secondary)
                    .padding(.top, 8)
                    
                    HStack {
                        Image(systemName: "graduationcap.fill")
                        Text(user.university)
                        Button(action: {
                            // Edit profile action
                        }) {
                            Text("edit profile")
                                .padding(.horizontal, 24)
                                .padding(.vertical, 8)
                                .background(Color.gray.opacity(0.2))
                                .cornerRadius(20)
                                .foregroundColor(.primary)
                        }
                    }
                    .font(.subheadline)
                    .foregroundColor(.secondary)
                    .padding(.top, 8)
                    
                    Divider()
                    
                    Picker("", selection: $selectedTab) {
                        Text("Listings").tag(0)
                        Text("Likes").tag(1)
                    }
                    .pickerStyle(SegmentedPickerStyle())
                    .padding(.horizontal)
                    
                    // Content based on selected tab
                    if selectedTab == 0 {
                        ListingsProfileView()
                    } else {
                        LikesView()
                    }

                    Spacer()
                }
                .padding()
            }
            .navigationTitle("Profile")
        }
    }
}
