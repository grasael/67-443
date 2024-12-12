//
//  QuizView.swift
//  rently
//
//  Created by Grace Liao on 11/27/24.
//

import Foundation
import SwiftUI

struct QuizView: View {
    @State private var selectedStyles: [String] = []
    @State private var selectedEvents: [String] = []
    
    private let styles = ["vintage", "sportswear", "edgy", "preppy", "boho chic", "grunge", "classy", "casual", "streetwear", "y2k", "trendy"]
    private let events = ["formal events", "business casual", "party", "athleisure", "vacation", "rave", "concert", "costume", "graduation", "job interview"]
    
    var body: some View {
        VStack(spacing: 20) {
            Text("let’s get you set up")
                .font(.title)
                .fontWeight(.bold)
                .multilineTextAlignment(.center)
                .padding(.top, 20)
            
            Divider()
                .frame(height: 2)
                .overlay(LinearGradient(colors: [.blue, .green], startPoint: .leading, endPoint: .trailing))
                .padding(.horizontal)
            
            VStack(alignment: .leading, spacing: 16) {
                // Style Question
                Text("how would you describe your style? (select at least 2)")
                    .font(.subheadline)
                
                WrapHStack(items: styles, selectedItems: $selectedStyles, selectedColor: .blue) // Sky blue for styles
                
                // Event Question
                Text("what types of events are you generally looking to rent clothes for? (select at least 2)")
                    .font(.subheadline)
                
                WrapHStack(items: events, selectedItems: $selectedEvents, selectedColor: .green) // Light green for events
            }
            .padding(.horizontal)
            
            Spacer()
            
            // Navigation Buttons
            HStack {
                Button(action: {
                    // Handle Back Action
                }) {
                    Text("back")
                        .foregroundColor(.black)
                        .padding()
                        .frame(maxWidth: .infinity)
                }
                .background(
                    RoundedRectangle(cornerRadius: 10)
                        .stroke(Color.gray, lineWidth: 1)
                )
                
                Button(action: {
                    // Handle Next Action
                    if selectedStyles.count >= 2 && selectedEvents.count >= 2 {
                        print("Proceed to the next screen")
                    } else {
                        print("Please select at least 2 styles and 2 events")
                    }
                }) {
                    Text("next")
                        .foregroundColor(.white)
                        .padding()
                        .frame(maxWidth: .infinity)
                }
                .background(
                    LinearGradient(colors: [.blue, .green], startPoint: .leading, endPoint: .trailing)
                        .cornerRadius(10)
                )
                .disabled(selectedStyles.count < 2 || selectedEvents.count < 2)
                .opacity((selectedStyles.count < 2 || selectedEvents.count < 2) ? 0.6 : 1.0)
            }
            .padding(.horizontal)
        }
        .padding()
    }
}

// Reusable Chip Layout
// Reusable Chip Layout
struct WrapHStack: View {
    let items: [String]
    @Binding var selectedItems: [String]
    var selectedColor: Color // Add this parameter to define the color for selected items
    
    var body: some View {
        LazyVGrid(columns: [GridItem(.adaptive(minimum: 100), spacing: 12)], spacing: 12) {
            ForEach(items, id: \.self) { item in
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
                        .background(selectedItems.contains(item) ? selectedColor.opacity(0.2) : Color.gray.opacity(0.2))
                        .foregroundColor(.primary)
                        .cornerRadius(16)
                }
            }
        }
    }
}

// Preview
//struct QuizView_Previews: PreviewProvider {
//    static var previews: some View {
//        QuizView()
//    }
//}
#Preview {
    QuizView()
}
