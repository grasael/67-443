//
//  ProfileView.swift
//  rently
//
//  Created by Grace Liao on 10/27/24.
//

import SwiftUI

struct ProfileView: View {
    var body: some View {
        HStack {
            Image(systemName: "person.circle.fill")
                .resizable()
                .frame(width: 80, height: 80)
                .foregroundColor(.gray)
            
            VStack(alignment: .leading) {
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
            Image(systemName: "gearshape.fill")
                .font(.title2)
                .foregroundColor(.gray)
        }
        .padding(.horizontal)
        
        HStack() {
            Text("90 followers")
            Text("70 following")
            Text("10 rented")
        }
        .font(.subheadline)
        .foregroundColor(.secondary)
        
        HStack {
            Image(systemName: "graduationcap.fill")
            Text("Carnegie Mellon University")
        }
        .font(.subheadline)
        .foregroundColor(.secondary)
        
        
    }
}

#Preview {
    ProfileView()
}
