//
//  SuggestedItemsView.swift
//  rently
//
//  Created by Tishyaa Chaudhry on 11/2/24.
//

import Foundation
import SwiftUI

struct SuggestedItemsView: View {
  @StateObject private var viewModel = ListingsViewModel()
  
  var body: some View {
    VStack(alignment: .leading, spacing: 10) {
      HStack {
        Text("we thought you would like")
          .font(.headline)
        Spacer()
        Text("see all")
          .foregroundColor(.blue)
          .onTapGesture {
            // Action for see all
          }
      }
      
      ScrollView(.horizontal, showsIndicators: false) {
        HStack(spacing: 15) {
          ForEach(viewModel.listings.prefix(5)) { listing in
            VStack {
              // Replace with AsyncImage to load images from URL
              if let imageUrl = URL(string: listing.photoURLs.first ?? "sampleItemImage") {
                AsyncImage(url: imageUrl) { phase in
                  switch phase {
                  case .empty:
                    ProgressView() // Show a loading indicator while the image is loading
                      .frame(width: 80, height: 80)
                  case .success(let image):
                    image
                      .resizable()
                      .scaledToFill()
                      .frame(width: 80, height: 80)
                      .clipped()
                      .cornerRadius(8)
                  case .failure:
                    Image("sampleItemImage") // Fallback image in case of error
                      .resizable()
                      .frame(width: 80, height: 80)
                      .cornerRadius(8)
                  @unknown default:
                    EmptyView()
                  }
                }
              }
              Text(listing.title)
              Text("$\(listing.price, specifier: "%.2f")/day")
              Text("size \(listing.size.rawValue)")
            }
          }
        }
      }
      .onAppear {
        viewModel.fetchListings() // Fetch listings when the view appears
      }
    }
  }
  
}
