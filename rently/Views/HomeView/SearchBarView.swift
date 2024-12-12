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
  
    @ObservedObject var userManager = UserManager.shared
    
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
            
            Text("Hi, \(userManager.user?.firstName ?? "Guest")!")
                .font(.largeTitle)
                .foregroundColor(.green)
        }
        .onAppear {
            // Ensure user data is loaded
            if userManager.user == nil {
                print("No user loaded; consider handling this case if necessary.")
            }
        }
    }
}
