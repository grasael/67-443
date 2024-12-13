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
            Text("trending searches on campus")
                .font(.headline)
                .padding(.bottom, 10)
          
            // image carousel
            ScrollView(.horizontal, showsIndicators: false) {
                HStack(spacing: 20) {
                    ForEach(viewModel.trendingItems) { item in
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
                                .font(.system(size: 13))
                                .multilineTextAlignment(.center)
                                .lineLimit(2)
                                .frame(width: 80)
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
