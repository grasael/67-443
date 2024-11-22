//
//  ProfileView.swift
//  rently
//
//  Created by Grace Liao on 10/27/24.
//

import SwiftUI

struct ProfileView: View {
    let user: User
    @StateObject private var listingsViewModel = ListingsViewModel() // Create an instance of ListingsViewModel
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
                        Text("0 followers")
                        Text("0 following")
                        Text("0 rented")
                    }
                    .font(.subheadline)
                    .foregroundColor(.secondary)
                    .padding(.top, 8)
                    
                    HStack {
                        Image(systemName: "graduationcap.fill")
                        Text(user.university)
                        Button(action: {
                            
                        }) {
                            Text("edit profile")
                                .font(.system(size: 16, weight: .medium))
                                .foregroundColor(.white)
                                .padding(.horizontal, 24)
                                .padding(.vertical, 8)
                        }
                        .background(
                            LinearGradient(
                                gradient: Gradient(colors: [Color.blue.opacity(0.7), Color.green.opacity(0.7)]),
                                startPoint: .leading,
                                endPoint: .trailing
                            )
                        )
                        .cornerRadius(20)
                        .shadow(radius: 2)
                    }
                    .font(.subheadline)
                    .foregroundColor(.secondary)
                    .padding(.top, 8)
                    
                    Divider()
                    
                    Picker("", selection: $selectedTab) {
                        Text("Listings (\(listingsViewModel.listingsCount))").tag(0)
                        Text("Likes").tag(1)
                    }
                    .pickerStyle(SegmentedPickerStyle())
                    .padding(.horizontal)
                    
                    if selectedTab == 0 {
                        ListingsProfileView()
                            .environmentObject(listingsViewModel)
                    } else {
                        LikesView()
                    }

                    Spacer()
                }
                .padding()
            }
            .navigationTitle("Profile")
            .onAppear {
                listingsViewModel.fetchListings()
            }
        }
    }
}
