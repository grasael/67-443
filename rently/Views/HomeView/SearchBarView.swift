//
//  SearchBarView.swift
//  rently
//
//  Created by Tishyaa Chaudhry on 11/2/24.
//

import SwiftUI

struct SearchBarView: View {
    @Binding var searchText: String

    var body: some View {
        VStack(alignment: .leading, spacing: 20) {
            HStack {
                TextField("Search for an item...", text: $searchText)
                    .padding(10)
                    .background(Color.white)
                    .cornerRadius(8)
                    .overlay(
                        RoundedRectangle(cornerRadius: 8)
                            .stroke(Color.gray.opacity(0.3), lineWidth: 1)
                    )
                Button(action: {
                    // Action for filter
                }) {
                    Image(systemName: "slider.horizontal.3")
                        .padding()
                        .background(Color.white)
                        .cornerRadius(8)
                }
            }
        }
    }
}
