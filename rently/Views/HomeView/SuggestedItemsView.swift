//
//  SuggestedItemsView.swift
//  rently
//
//  Created by Tishyaa Chaudhry on 11/2/24.
//

import Foundation
import SwiftUI

struct SuggestedItemsView: View {
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
                    ForEach(0..<5) { index in
                        VStack {
                            Image("sampleItemImage") // Replace with actual image
                                .resizable()
                                .frame(width: 80, height: 80)
                                .cornerRadius(8)
                            Text("black tuxedo")
                            Text("$10/day")
                            Text("size L")
                        }
                    }
                }
            }
        }
    }
}
