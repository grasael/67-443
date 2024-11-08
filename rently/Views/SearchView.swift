//
//  SearchView.swift
//  rently
//
//  Created by Grace Liao on 10/27/24.
//

import SwiftUI

struct SearchView: View {
    @ObservedObject var viewModel = SearchViewModel()

    var body: some View {
        NavigationView {
            VStack {
                // Search bar at the top
                HStack {
                    TextField("Search for anything...", text: $viewModel.searchText, onCommit: {
                        viewModel.performSearch()
                    })
                    .padding(8)
                    .background(Color(.systemGray5))
                    .cornerRadius(8)
                    
                    if !viewModel.searchText.isEmpty {
                        Button(action: {
                            viewModel.clearSearch()
                        }) {
                            Image(systemName: "xmark.circle.fill")
                                .foregroundColor(.gray)
                        }
                    }
                }
                .padding()

                // Display categories if searchText is empty
                if viewModel.searchText.isEmpty {
                    VStack(alignment: .leading) {
                        Text("Shop by category")
                            .font(.headline)
                            .padding(.horizontal)

                        // Categories grid (replace with actual icons/images)
                        ScrollView(.horizontal, showsIndicators: false) {
                            HStack(spacing: 16) {
                                CategoryIconView(iconName: "tshirt", label: "tops")
                                CategoryIconView(iconName: "pants", label: "bottoms")
                                CategoryIconView(iconName: "coat", label: "outerwear")
                                CategoryIconView(iconName: "dress", label: "dresses")
                                // Add more categories as needed
                            }
                            .padding(.horizontal)
                        }

                        // Seasonal themes
                        SeasonalThemesView()
                    }
                } else {
                    // Display search results if searchText is not empty
                    List {
                        if !viewModel.filteredListings.isEmpty {
                            Section(header: Text("Listings")) {
                                ForEach(viewModel.filteredListings) { listing in
                                    ListingRow(listing: listing)
                                }
                            }
                        }
                        
                        if !viewModel.filteredUsers.isEmpty {
                            Section(header: Text("Profiles")) {
                                ForEach(viewModel.filteredUsers) { user in
                                    UserProfileRow(user: user)
                                }
                            }
                        }
                    }
                }
            }
            .navigationTitle("rently")
        }
    }
}

// Category icon view for "Shop by category" section
struct CategoryIconView: View {
    var iconName: String
    var label: String

    var body: some View {
        VStack {
            Image(systemName: iconName)
                .resizable()
                .frame(width: 40, height: 40)
                .padding()
            Text(label)
                .font(.caption)
        }
    }
}

// Seasonal themes view
struct SeasonalThemesView: View {
    var body: some View {
        VStack(alignment: .leading, spacing: 16) {
            // Each theme item can be replaced with relevant images
            SeasonalThemeView(imageName: "interviewSeason", title: "interview season")
            SeasonalThemeView(imageName: "winterBreak", title: "winter break")
            SeasonalThemeView(imageName: "halloween", title: "halloween")
        }
        .padding(.horizontal)
    }
}

struct SeasonalThemeView: View {
    var imageName: String
    var title: String

    var body: some View {
        ZStack(alignment: .bottomLeading) {
            Image(imageName)
                .resizable()
                .scaledToFill()
                .frame(height: 120)
                .clipped()
            Text(title)
                .foregroundColor(.white)
                .padding(8)
                .background(Color.black.opacity(0.7))
                .cornerRadius(4)
        }
    }
}

#Preview {
    SearchView()
}
