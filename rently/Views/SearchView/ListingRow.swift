//
//  ListingRow.swift
//  rently
//
//  Created by Sara Riyad on 11/7/24.
//

import Foundation
import SwiftUI

struct ListingRow: View {
    var listing: Listing
    
    var body: some View {
        HStack {
            VStack(alignment: .leading) {
                Text(listing.title)
                    .font(.headline)
                Text("\(listing.price, specifier: "%.2f") per day")
                    .font(.subheadline)
                    .foregroundColor(.gray)
            }
            Spacer()
        }
        .padding()
    }
}
