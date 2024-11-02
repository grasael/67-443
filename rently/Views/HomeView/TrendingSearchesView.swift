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
    var body: some View {
        VStack(alignment: .leading, spacing: 10) {
            Text("trending searches on campus")
                .font(.headline)
            ScrollView(.horizontal, showsIndicators: false) {
                HStack(spacing: 20) {
                    ForEach(0..<5) { index in
                        VStack {
                            Circle()
                                .fill(Color.gray.opacity(0.2))
                                .frame(width: 80, height: 80) // Increased size of the circles
                            Text("formal dress")
                        }
                    }
                }
            }
        }
    }
}
