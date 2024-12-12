//
//  QuizView.swift
//  rently
//
//  Created by Grace Liao on 11/27/24.
//

import Foundation
import SwiftUI
import Combine

struct QuizView: View {
    @State private var selectedStyles: [String] = []
    @State private var selectedEvents: [String] = []
    @ObservedObject var userViewModel: UserViewModel
    @Environment(\.presentationMode) var presentationMode
    
    private let styles = ["vintage", "sportswear", "edgy", "preppy", "boho chic", "grunge", "classy", "casual", "streetwear", "y2k", "trendy"]
    private let events = ["formal events", "business casual", "party", "athleisure", "vacation", "rave", "concert", "costume", "graduation", "job interview"]
    
    @State private var navigateToAppView = false
    @State private var cancellables = Set<AnyCancellable>()
    
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
                    presentationMode.wrappedValue.dismiss() // Go back to OnboardingView
                }) {
                    Text("Back")
                        .foregroundColor(.white)
                        .padding(.vertical, 10)
                        .padding(.horizontal, 40)
                }
                .background(Color.gray.opacity(0.7).cornerRadius(10))
                
                Button(action: finishOnboarding) {
                    Text("Next")
                        .foregroundColor(.white)
                        .padding(.vertical, 10)
                        .padding(.horizontal, 40)
                }
                .background(
                    LinearGradient(colors: [.blue, .green], startPoint: .leading, endPoint: .trailing)
                        .cornerRadius(10)
                )
                .disabled(selectedStyles.count < 2 || selectedEvents.count < 2)
                .opacity((selectedStyles.count < 2 || selectedEvents.count < 2) ? 0.6 : 1.0)
            }
            .padding(.horizontal)
            
            .fullScreenCover(isPresented: $navigateToAppView) {
                AppView(viewModel: userViewModel)
            }
        }
        .padding()
    }
    
    private func finishOnboarding() {
            guard selectedStyles.count >= 2, selectedEvents.count >= 2 else {
                print("Please select at least 2 styles and 2 events")
                return
            }
            
            // Add the style and event selections to the user object
            userViewModel.user.styleChoices = selectedStyles
            userViewModel.user.events = selectedEvents
            
            // Save the user to the backend
            userViewModel.addUser()

            userViewModel.$user
                .handleEvents(receiveOutput: { user in
                    print("🔍 User emitted from $user: \(user)")
                })
                .compactMap { $0.id }
                .first()
                .sink { id in
                    print("🌟 User ID available: \(id)")
                    print("🔗 Navigating to AppView...")
                    DispatchQueue.main.asyncAfter(deadline: .now() + 0.1) {
                        self.navigateToAppView = true
                    }
                }
                .store(in: &cancellables)
        }
}


// Reusable Chip Layout
struct WrapHStack: View {
    let items: [String]
    @Binding var selectedItems: [String]
    var selectedColor: Color
    
    var body: some View {
        LazyVGrid(columns: [GridItem(.adaptive(minimum: 100), spacing: 12)], spacing: 12) {
            ForEach(items, id: \.self) { item in
                Button(action: {
                    if selectedItems.contains(item) {
                        selectedItems.removeAll { $0 == item }
                        print("Deselected: \(item)") // Debugging: Print deselection
                    } else {
                        selectedItems.append(item)
                        print("Selected: \(item)") // Debugging: Print selection
                    }
                    print("Current selections: \(selectedItems)") // Debugging: Print current selections
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
