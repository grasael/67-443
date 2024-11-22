//
//  CardView.swift
//  rently
//
//  Created by Grace Liao on 11/17/24.
//

import Foundation
import SwiftUI

struct CardView: View {
    let listing: Listing

    var body: some View {
        VStack(alignment: .leading, spacing: 8) {
            if let imageUrl = listing.photoURLs.first {
                AsyncImage(url: URL(string: imageUrl)) { image in
                    image
                        .resizable()
                        .aspectRatio(contentMode: .fill)
                        .frame(width: 150, height: 200)
                        .clipped()
                        .cornerRadius(10)
                } placeholder: {
                    Rectangle()
                        .fill(Color.gray.opacity(0.3))
                        .frame(width: 150, height: 200)
                        .cornerRadius(10)
                }
            }

            Text(listing.title)
                .font(.headline)
                .lineLimit(1)

            Text("$\(listing.price, specifier: "%.2f")/day")
                .font(.subheadline)
                .foregroundColor(.gray)

            HStack {
                ForEach(listing.tags, id: \.self) { tag in
                    Text(tag.rawValue)
                        .font(.caption)
                        .padding(4)
                        .background(Color.gray.opacity(0.2))
                        .cornerRadius(5)
                }
            }
        }
        .padding()
        .background(Color.white)
        .cornerRadius(12)
        .shadow(radius: 4)
    }
}
