//
//  TrendingSearchesView.swift
//  rently
//
//  Created by Tishyaa Chaudhry on 11/2/24.
//

import Foundation
import SwiftUI

// MARK: - TrendingSearchesView
struct TrendingSearchesView: View {
    @StateObject private var viewModel = TrendingViewModel()
    
    var body: some View {
        VStack(alignment: .leading, spacing: 10) {
            Text("Trending Searches on Campus")
                .font(.headline)
            ScrollView(.horizontal, showsIndicators: false) {
                HStack(spacing: 20) {
                    ForEach(viewModel.trendingItems) { item in
                        // Make each item clickable, redirecting to the SearchView with the query
                        NavigationLink(destination: SearchView(query: item.name)) {
                            VStack {
                                AsyncImage(url: URL(string: item.thumbnailUrl)) { image in
                                    image
                                        .resizable()
                                        .aspectRatio(contentMode: .fill)
                                        .frame(width: 80, height: 80)
                                        .clipShape(Circle())
                                } placeholder: {
                                    Circle()
                                        .fill(Color.gray.opacity(0.2))
                                        .frame(width: 80, height: 80)
                                }
                                Text(item.name)
                                    .font(.subheadline)
                                    .foregroundColor(.primary)
                            }
                            .padding(.vertical, 5)
                        }
                    }
                }
            }
        }
        .onAppear {
            viewModel.fetchTrendingItems()
        }
    }
}
