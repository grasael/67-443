//
//  ActiveRentalsView.swift
//  rently
//
//  Created by Tishyaa Chaudhry on 11/2/24.
//

import Foundation
import SwiftUI

// MARK: - ActiveRentalsView
struct ActiveRentalsView: View {
    var body: some View {
        VStack(alignment: .leading, spacing: 10) {
            HStack {
                Text("your active rentals")
                    .font(.headline)
                Spacer()
                NavigationLink(destination: RentalsView()) { // Navigate to RentalsView
                    Text("see all")
                        .foregroundColor(.blue)
                }
            }
            
            ScrollView(.horizontal, showsIndicators: false) {
                HStack(spacing: 15) {
                    ForEach(0..<5) { index in // Replace 5 with the count of active rentals in your data
                        ActiveRentalCard()
                    }
                }
                .padding(.vertical)
            }
        }
        .padding(.horizontal)
    }
}
