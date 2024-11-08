//
//  SearchView.swift
//  rently
//
//  Created by Grace Liao on 10/27/24.
//

import SwiftUI

struct SearchView: View {
    @StateObject private var viewModel = SearchViewModel()

    var body: some View {
        NavigationView {
            List(viewModel.listings) { listing in
                NavigationLink(destination: ListingDetailView(listingID: listing.id)) {
                    HStack {
                        AsyncImage(url: URL(string: listing.photoURLs.first ?? "")) { image in
                            image.resizable()
                                .aspectRatio(contentMode: .fill)
                                .frame(width: 50, height: 50)
                                .clipShape(RoundedRectangle(cornerRadius: 8))
                        } placeholder: {
                            Color.gray
                                .frame(width: 50, height: 50)
                                .clipShape(RoundedRectangle(cornerRadius: 8))
                        }

                        VStack(alignment: .leading) {
                            Text(listing.title)
                                .font(.headline)
                            Text("$\(String(format: "%.2f", listing.price))/day")
                                .font(.subheadline)
                        }
                    }
                }
            }
            .navigationTitle("Search Listings")
            .onAppear {
                viewModel.fetchListings()
            }
        }
    }
}

#Preview {
    SearchView()
}
