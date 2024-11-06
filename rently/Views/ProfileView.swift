//
//  ProfileView.swift
//  rently
//
//  Created by Grace Liao on 10/27/24.
//

import SwiftUI

struct ProfileView: View {
    @State private var selectedTab = 0 // 0 for Listings, 1 for Likes

    var body: some View {
        VStack {
            HStack{
                Spacer()
                Image(systemName: "gearshape.fill")
                    .font(.title2)
                    .foregroundColor(.gray)
            }

            HStack {
                Image(systemName: "person.circle.fill")
                    .resizable()
                    .frame(width: 80, height: 80)
                    .foregroundColor(.gray)
                
                HStack() {
                    Text("amelia bose")
                        .font(.title2)
                        .fontWeight(.bold)
                    
                    HStack(spacing: 2) {
                        Text("5")
                        Image(systemName: "star.fill")
                            .foregroundColor(.yellow)
                    }
                }
                Spacer()

            }
            .padding(.horizontal)
            
            HStack() {
                //This will be clickable in V2
                Text("90 followers")
                //This will be clikcable in V2
                Text("70 following")
                Text("10 rented")
            }
            .font(.subheadline)
            .foregroundColor(.secondary)
            
            HStack {
                Image(systemName: "graduationcap.fill")
                Text("Carnegie Mellon University")
                Button(action: {
                    // Edit profile action
                    // Will add functionality to this later
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
            

        }.padding(.top)
        
        Divider()
        
        Picker("", selection: $selectedTab) {
            Text("Listings").tag(0)
            Text("Likes").tag(1)
        }
        .pickerStyle(SegmentedPickerStyle())
        .padding(.horizontal)
        
        // Content based on selected tab
        if selectedTab == 0 {
            //Should add another view
            ListView()
        } else {
            LikesView()
        }

        Spacer()

    }
}

#Preview {
    ProfileView()
}
