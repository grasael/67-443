//
//  ListingsProfileView.swift
//  rently
//
//  Created by Grace Liao on 11/8/24.
//
// These are just all the ones inside of Firebase for testing purposes only... need to filter for a specific user later

import SwiftUI

struct ListingsProfileView: View {
    @StateObject private var viewModel = ListingsViewModel()

    let columns = [
        GridItem(.flexible()),
        GridItem(.flexible())
    ]

    var body: some View {
        ScrollView {
            LazyVGrid(columns: columns, spacing: 20) {
                ForEach(viewModel.listings) { listing in
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

                        // Title
                        Text(listing.title)
                            .font(.headline)
                            .lineLimit(1)

                        // Price per day
                        Text("$\(listing.price, specifier: "%.2f")/day")
                            .font(.subheadline)
                            .foregroundColor(.gray)

                        // Tags
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
            .padding(.horizontal)
        }
        .onAppear {
            viewModel.fetchListings()
        }
        .navigationTitle("Profile")
    }
}

struct ListingsProfileView_Previews: PreviewProvider {
    static var previews: some View {
        ListingsProfileView()
    }
}
