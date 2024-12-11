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
                .minimumScaleFactor(0.7)
                .foregroundColor(.black)

          // listing price
            Text("$\(listing.price, specifier: "%.2f")/day")
                .font(.subheadline)
                .minimumScaleFactor(0.7)
                .foregroundColor(.gray)
          
          // tags
          HStack {
            ForEach(listing.tags.prefix(3), id: \.self) { tag in
                Text(tag.rawValue)
                    .font(.caption)
                    .lineLimit(1)
                    .minimumScaleFactor(0.5)
                    .padding(.horizontal, 8)
                    .padding(.vertical, 4)
                    .background(Color("MediumBlue"))
                    .cornerRadius(5)
                    .foregroundColor(.white)
            }
        }
        .frame(maxWidth: .infinity, alignment: .leading)
        }
        .padding()
        .background(Color.white)
        .cornerRadius(12)
    }
}
