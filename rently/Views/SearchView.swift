//
//  SearchView.swift
//  rently
//
//  Created by Grace Liao on 10/27/24.
//


import SwiftUI

struct SearchView: View {
    @ObservedObject var viewModel = SearchViewModel()
    @State private var searchText = ""
    @State private var isSearching = false

    var body: some View {
        VStack(alignment: .leading, spacing: 20) {
            // Header with Logo and Search Bar
            HStack {
                Text("rently")
                    .font(.largeTitle)
                    .foregroundColor(Color.blue.opacity(0.7))
                    .bold()
                Spacer()
                Image(systemName: "slider.horizontal.3")
                    .font(.title2)
                    .foregroundColor(.black)
            }
            .padding(.horizontal)

            // Search Bar
            HStack {
                Image(systemName: "magnifyingglass")
                    .foregroundColor(.gray)
                TextField("search for anything...", text: $searchText, onEditingChanged: { isEditing in
                    isSearching = !searchText.isEmpty
                })
                .padding(8)
                .onChange(of: searchText) { newValue in
                    viewModel.performSearch(query: newValue)
                    isSearching = !newValue.isEmpty
                }
                if isSearching {
                    Button(action: {
                        searchText = ""
                        isSearching = false
                    }) {
                        Image(systemName: "xmark.circle.fill")
                            .foregroundColor(.gray)
                    }
                }
            }
            .background(Color(UIColor.systemGray5))
            .cornerRadius(16)
            .padding(.horizontal)

            // Conditional View: Show initial view or search results based on isSearching state
            if isSearching {
                // Search Results View
                ScrollView {
                    Text("Search Results for '\(searchText)'")
                        .font(.headline)
                        .padding(.horizontal)
                    
                    // Display matching listings
                    ForEach(viewModel.listings, id: \.id) { listing in
                        ListingRow(listing: listing)
                    }

                    // Display matching user profiles
                    ForEach(viewModel.users, id: \.id) { user in
                        UserProfileRow(user: user)
                    }
                }
                .padding(.horizontal)
            } else {
                // Initial View with Categories and Seasonal Sections
                VStack(alignment: .leading, spacing: 12) {
                    // Category Section
                    Text("shop by category")
                        .font(.headline)
                        .padding(.horizontal)
                    
                    ScrollView(.horizontal, showsIndicators: false) {
                        HStack(spacing: 20) {
                            CategoryIcon(name: "tops", iconURL: URL(string: "https://cdn-icons-png.flaticon.com/512/4267/4267723.png")!) {
                                searchCategory("tops")
                            }
                            CategoryIcon(name: "bottoms", iconURL: URL(string: "https://cdn-icons-png.flaticon.com/512/808/808726.png")!) {
                                searchCategory("bottoms")
                            }
                            CategoryIcon(name: "outerwear", iconURL: URL(string: "https://images.vexels.com/media/users/3/142974/isolated/preview/804b58e4b241aec0a4fa8a9b6fe22e41-stroke-striped-jacket-clothing.png")!) {
                                searchCategory("outerwear")
                            }
                            CategoryIcon(name: "dresses", iconURL: URL(string: "https://icons.veryicon.com/png/o/internet--web/website-common-icons/dress-122.png")!) {
                                searchCategory("dresses")
                            }
                        }
                        .padding(.horizontal)
                    }

                    // Seasonal Sections
                    ScrollView {
                        VStack(spacing: 12) {
                            SeasonalSection(imageURL: URL(string: "https://sc-cms-prod103-cdn-dsb5cvath4adbgd0.z01.azurefd.net/-/media/images/astoncarter/insights/articles/gettyimages1443303360-jpg.jpg?rev=78cdd90832394584b7570407c585f1e8")!, title: "interview season") {
                                searchCategory("interview season")
                            }
                            SeasonalSection(imageURL: URL(string: "https://media.istockphoto.com/id/1388581317/photo/figure-skating-lady-is-wearing-black-sportswear-is-skating-on-ice-rink-training-at-night-in.jpg?s=612x612&w=0&k=20&c=KFjeMcUvYbaYvcYEUBgz5rzpjMBfCtKvgdV57Dv_pMs=")!, title: "winter break") {
                                searchCategory("winter break")
                            }
                            SeasonalSection(imageURL: URL(string: "https://assets.editorial.aetnd.com/uploads/2009/11/halloween-gettyimages-1424736925.jpg")!, title: "halloween") {
                                searchCategory("halloween")
                            }
                        }
                    }
                    .padding(.horizontal)
                }
            }
            Spacer()
        }
        .onAppear {
            viewModel.fetchListings()
            viewModel.fetchUsers()
        }
    }
    
    // Helper function to perform search and set state
    private func searchCategory(_ category: String) {
        searchText = category
        viewModel.performSearch(query: category)
        isSearching = true
    }
}

struct CategoryIcon: View {
    let name: String
    let iconURL: URL
    let onSearch: () -> Void

    var body: some View {
        VStack {
            Button(action: onSearch) {
                AsyncImage(url: iconURL) { phase in
                    if let image = phase.image {
                        image
                            .resizable()
                            .scaledToFit()
                            .frame(width: 40, height: 40)
                            .padding()
                            .background(Color(UIColor.systemGray5))
                            .clipShape(Circle())
                    } else if phase.error != nil {
                        Image(systemName: "xmark.circle")
                            .resizable()
                            .scaledToFit()
                            .frame(width: 40, height: 40)
                            .padding()
                            .background(Color(UIColor.systemGray5))
                            .clipShape(Circle())
                    } else {
                        ProgressView()
                            .frame(width: 40, height: 40)
                            .padding()
                            .background(Color(UIColor.systemGray5))
                            .clipShape(Circle())
                    }
                }
            }
            Text(name)
                .font(.caption)
                .foregroundColor(.black)
        }
    }
}

struct SeasonalSection: View {
    let imageURL: URL
    let title: String
    let onSearch: () -> Void

    var body: some View {
        ZStack(alignment: .center) {
            Button(action: onSearch) {
                AsyncImage(url: imageURL) { phase in
                    if let image = phase.image {
                        image
                            .resizable()
                            .scaledToFill()
                            .frame(height: 120)
                            .clipped()
                            .cornerRadius(16)
                    } else if phase.error != nil {
                        Color.gray
                            .frame(height: 120)
                            .cornerRadius(16)
                    } else {
                        ProgressView()
                            .frame(height: 120)
                            .background(Color.gray)
                            .cornerRadius(16)
                    }
                }
            }
            Text(title)
                .font(.headline)
                .foregroundColor(.white)
                .shadow(radius: 5)
        }
    }
}

#Preview {
    SearchView()
}
