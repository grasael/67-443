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
                        .frame(height: 200)
                        .frame(maxWidth: .infinity)
                        .clipped()
                        .cornerRadius(10)
                } placeholder: {
                    Rectangle()
                        .fill(Color.gray.opacity(0.3))
                        .frame(height: 200)
                        .frame(maxWidth: .infinity)
                        .cornerRadius(10)
                }
            }

            Text(listing.title)
                .font(.headline)
                .minimumScaleFactor(0.7)
                .foregroundColor(.black)

            Text("$\(listing.price, specifier: "%.2f")/day")
                .font(.subheadline)
                .foregroundColor(.gray)

            HStack {
                ForEach(listing.tags, id: \.self) { tag in
                    Text(tag.rawValue)
                        .font(.caption)
                        .foregroundColor(.white)
                        .padding(4)
                        .background(Color("MediumBlue"))
                        .cornerRadius(5)
                        .lineLimit(1)
                        .minimumScaleFactor(0.7)
                }
            }
        }
        .padding()
        .background(Color.white)
        .cornerRadius(12)
    }
}
