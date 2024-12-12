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
          // image
            if let imageUrl = listing.photoURLs.first {
                AsyncImage(url: URL(string: imageUrl)) { image in
                    image
                        .resizable()
                        .aspectRatio(1, contentMode: .fill)
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

          // listing title
            Text(listing.title)
                .font(.headline)
                .lineLimit(1)
                .foregroundColor(.black)

          // listing price
            Text("$\(listing.price, specifier: "%.2f")/day")
                .font(.subheadline)
                .foregroundColor(.gray)
          
          // Tags Section
          if !listing.tags.isEmpty {
              HStack(spacing: 8) {
                  ForEach(listing.tags.prefix(2), id: \.self) { tag in
                      Text(tag.rawValue)
                          .font(.caption)
                          .padding(.horizontal, 8)
                          .padding(.vertical, 4)
                          .background(Color("MediumBlue"))
                          .cornerRadius(20)
                          .foregroundColor(.white)
                          .lineLimit(1)
                  }
              }
              .frame(maxWidth: .infinity, alignment: .leading)
              .padding(.top, 4)
          }
        }
        .padding()
        .background(Color.white)
        .cornerRadius(12)
        .frame(width: 150) // Fix the width for consistent layout
        .alignmentGuide(.top) { _ in 0 }
    }
}
