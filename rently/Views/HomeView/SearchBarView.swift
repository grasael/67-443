//
//  SearchBarView.swift
//  rently
//
//  Created by Tishyaa Chaudhry on 11/2/24.
//

import Foundation
import SwiftUI

// MARK: - SearchBarView
struct SearchBarView: View {
    @EnvironmentObject var userViewModel: UserViewModel // Access user data
    
    var body: some View {
        VStack(alignment: .leading, spacing: 20) {
        
            
            HStack {
                TextField("search for an item...", text: .constant(""))
                    .padding(10)
                    .background(Color.white)
                    .cornerRadius(8)
                    .overlay(
                        RoundedRectangle(cornerRadius: 8)
                            .stroke(Color.gray.opacity(0.3), lineWidth: 1)
                    )
                Button(action: {
                    // Action for filter
                }) {
                    Image(systemName: "slider.horizontal.3")
                        .padding()
                        .background(Color.white)
                        .cornerRadius(8)
                }
            }
            // Display "Hi, {firstName}" dynamically
          Text("Hi, \(userViewModel.user.firstName)!")
                .font(.largeTitle)
                .foregroundColor(.green)
        }
    }
}
