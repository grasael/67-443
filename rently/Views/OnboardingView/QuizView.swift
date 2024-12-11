//
//  QuizView.swift
//  rently
//
//  Created by Grace Liao on 11/27/24.
//

import Foundation
import SwiftUI

struct QuizView: View {
    @ObservedObject var userViewModel: UserViewModel
    
    @State private var selectedStyles: [String] = []
    @State private var selectedEvents: [String] = []
    
    let styleChoices = ["vintage", "sportswear", "edgy", "preppy", "boho chic", "grunge", "classy", "casual", "streetwear", "y2k", "trendy"]
    let eventChoices = ["formal events", "business casual", "party", "athleisure", "vacation", "rave", "concert", "costume", "graduation", "job interview"]
    
    var body: some View {
        VStack(spacing: 20) {
            Text("let’s get you set up")
                .font(.title)
                .bold()
            
            VStack(alignment: .leading, spacing: 16) {
                Text("how would you describe your style? (select at least 2)")
                    .font(.headline)
                
                WrapHStack(items: styleChoices, selectedItems: $selectedStyles)
            }
            
            VStack(alignment: .leading, spacing: 16) {
                Text("what types of events are you generally looking to rent clothes for? (select at least 2)")
                    .font(.headline)
                
                WrapHStack(items: eventChoices, selectedItems: $selectedEvents)
            }
            
            Spacer()
            
            HStack {
                Button(action: {
                    // Navigate back
                }) {
                    Text("back")
                        .font(.headline)
                        .padding()
                        .frame(maxWidth: .infinity)
                        .background(Color.gray.opacity(0.2))
                        .cornerRadius(8)
                }
                
                Button(action: saveSelections) {
                    Text("next")
                        .font(.headline)
                        .padding()
                        .frame(maxWidth: .infinity)
                        .background(selectedStyles.count >= 2 && selectedEvents.count >= 2 ? Color.blue : Color.gray)
                        .foregroundColor(.white)
                        .cornerRadius(8)
                }
                .disabled(selectedStyles.count < 2 || selectedEvents.count < 2)
            }
        }
        .padding()
    }
    
    // Save the selections to the user's profile
    private func saveSelections() {
        userViewModel.user.styleChoices = selectedStyles
        userViewModel.user.events = selectedEvents
        userViewModel.updateUser() // Update user in Firestore or the repository
        print("Saved Style Choices: \(selectedStyles)")
        print("Saved Event Choices: \(selectedEvents)")
    }
}

struct WrapHStack: View {
    let items: [String]
    @Binding var selectedItems: [String]
    
    var body: some View {
        GeometryReader { geometry in
            let spacing: CGFloat = 8
            var totalWidth: CGFloat = 0
            var rows: [[String]] = [[]]
            
            ForEach(items, id: \.self) { item in
                let size = item.size(withFont: UIFont.systemFont(ofSize: 14))
                let itemWidth = size.width + 32
                
                if totalWidth + itemWidth + spacing > geometry.size.width {
                    rows.append([item])
                    totalWidth = itemWidth
                } else {
                    rows[rows.count - 1].append(item)
                    totalWidth += itemWidth + spacing
                }
            }
            
            VStack(alignment: .leading, spacing: spacing) {
                ForEach(rows, id: \.self) { row in
                    HStack(spacing: spacing) {
                        ForEach(row, id: \.self) { item in
                            Button(action: {
                                if selectedItems.contains(item) {
                                    selectedItems.removeAll { $0 == item }
                                } else {
                                    selectedItems.append(item)
                                }
                            }) {
                                Text(item)
                                    .font(.system(size: 14))
                                    .padding(.horizontal, 12)
                                    .padding(.vertical, 8)
                                    .background(selectedItems.contains(item) ? Color.blue.opacity(0.2) : Color.gray.opacity(0.2))
                                    .foregroundColor(.primary)
                                    .cornerRadius(16)
                            }
                        }
                    }
                }
            }
        }
    }
}

// Helper to calculate text size
extension String {
    func size(withFont font: UIFont) -> CGSize {
        let attributes: [NSAttributedString.Key: Any] = [.font: font]
        let size = (self as NSString).size(withAttributes: attributes)
        return size
    }
}


