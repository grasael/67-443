//
//  ActiveRentalCardView.swift
//  rently
//
//  Created by Tishyaa Chaudhry on 11/2/24.
//

import Foundation
import SwiftUI

// MARK: - ActiveRentalCard
struct ActiveRentalCard: View {
  var body: some View {
    HStack {
      VStack(alignment: .leading, spacing: 4) {
        HStack {
          Image(systemName: "calendar")
          Text("days until dropoff")
            .font(.subheadline) // Reduced font size
            .fixedSize(horizontal: false, vertical: true) // Prevents text breaking
        }
        Text("@ university center, 12 pm")
          .font(.footnote) // Smaller font for subtitle
          .foregroundColor(.gray)
          .fixedSize(horizontal: false, vertical: true)
      }
      Spacer()
      Image("sampleItemImage") // Replace with actual image
        .resizable()
        .scaledToFill()
        .frame(width: 60, height: 60) // Adjusted image size
        .cornerRadius(8)
      Button("view") {
        // Action for view
      }
      .frame(width: 60, height: 30)
      .background(Color.green)
      .foregroundColor(.white)
      .cornerRadius(8)
    }
    .padding()
    .background(Color.gray.opacity(0.1))
    .cornerRadius(12)
    .frame(width: 260) // Increased card width slightly
  }
}
