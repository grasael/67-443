//
//  SearchView.swift
//  rently
//
//  Created by Grace Liao on 10/27/24.
//

import Foundation
import SwiftUI

struct SearchView: View {
    @ObservedObject var userViewModel: UserViewModel
    @ObservedObject var viewModel = SearchViewModel()
    @State private var searchText = ""
    
    var body: some View {
        NavigationView {
            VStack(alignment: .leading, spacing: 20) {
                ZStack {
                    // Gradient Background Rectangle
                    LinearGradient(
                        gradient: Gradient(colors: [Color("MediumBlue"), .white]),
                        startPoint: .top,
                        endPoint: .bottom
                    )
                    .frame(width: 800, height: 150)
                    .edgesIgnoringSafeArea(.all)
                    
                    // Logo
                    HStack {
                        Image("rently_logo")
                            .resizable()
                            .scaledToFit()
                            .frame(width: 200, height: 60)
                            .layoutPriority(1)
                            .clipped()
                            .shadow(color: .gray.opacity(0.4), radius: 4, x: 6, y: 0)
                    }
                }

                // Search Bar
                HStack {
                    Image(systemName: "magnifyingglass")
                        .foregroundColor(.black)
                        .padding(.horizontal, 6)
                    TextField("search for anything...", text: $searchText)
                        .padding(8)
                        .onChange(of: searchText) { newValue in
                            viewModel.filterListingsAndUsers(query: newValue)
                        }
                    Spacer()
                    
                    Image(systemName: "slider.horizontal.3")
                        .font(.title2)
                        .foregroundColor(.black)
                        .padding(.horizontal, 6)
                }
                .background(.white)
                .cornerRadius(8)
                .overlay(
                    RoundedRectangle(cornerRadius: 8)
                        .stroke(Color.black, lineWidth: 1)
                )
                .padding(EdgeInsets(top: 0, leading: 25, bottom: 0, trailing: 10))
                
                // Show relevant results based on search query
                if !searchText.isEmpty {
                    List {
                        Section(header: Text("listings")) {
                            ForEach(viewModel.listings) { listing in
                                NavigationLink(destination: ListingDetailView(listing: listing).environmentObject(userViewModel)) { // Updated
                                    HStack {
                                        AsyncImage(url: URL(string: listing.photoURLs.first ?? ""), content: { phase in
                                            if let image = phase.image {
                                                image.resizable()
                                                    .scaledToFill()
                                                    .frame(width: 50, height: 50)
                                                    .clipShape(RoundedRectangle(cornerRadius: 10))
                                            } else if phase.error != nil {
                                                Image(systemName: "xmark.circle")
                                                    .frame(width: 50, height: 50)
                                            } else {
                                                ProgressView()
                                                    .frame(width: 50, height: 50)
                                            }
                                        })
                                        VStack(alignment: .leading) {
                                            Text(listing.title)
                                                .font(.headline)
                                            Text("$\(listing.price, specifier: "%.2f")")
                                                .font(.subheadline)
                                        }
                                    }
                                }
                                .listRowBackground(Color.white)
                            }
                        }

                        Section(header: Text("Users")) {
                            ForEach(viewModel.users) { user in
                                NavigationLink(
                                    destination: SearchUserDetailView(user: user, userViewModel: userViewModel)
                                ) {
                                    UserProfileRow(user: user)
                                }
                                .listRowBackground(Color.white)
                            }
                        }
                    }
                    .scrollContentBackground(.hidden)
                    .background(Color.white)
                }
                else {
                    // Default view with categories and seasonal sections
                    Text("shop by category")
                        .font(.headline)
                        .padding(.horizontal)
                    
                    ScrollView(.horizontal, showsIndicators: false) {
                        HStack(spacing: 20) {
                            CategoryIcon(name: "tops", iconImage: Image("tops")) {
                                searchForCategory("tops")
                            }
                            CategoryIcon(name: "bottoms", iconImage: Image("bottoms")) {
                                searchForCategory("bottoms")
                            }
                            CategoryIcon(name: "outerwear", iconImage: Image("outerwear")) {
                                searchForCategory("outerwear")
                            }
                            CategoryIcon(name: "dresses", iconImage: Image("dresses")) {
                                searchForCategory("dresses")
                            }
                        }
                        .frame(maxWidth: .infinity, alignment: .center)
                        .padding(EdgeInsets(top: 0, leading: 25, bottom: 0, trailing: 10))
                    }
                    
                    // Seasonal Sections
                    ScrollView {
                        VStack(spacing: 12) {
                            SeasonalSection(sectionImage: Image("interview_season"), title: "interview season") {
                                performSearchWithTag("interview")
                            }
                            SeasonalSection(sectionImage: Image("winter_break"), title: "winter break") {
                                performSearchWithTag("jacket")
                            }
                            SeasonalSection(sectionImage: Image("halloween"), title: "halloween") {
                                performSearchWithTag("costume")
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
    }
    
    // Helper method to handle category search
    private func searchForCategory(_ category: String) {
        searchText = category
        viewModel.filterListingsAndUsers(query: searchText)
    }
    
    private func performSearchWithTag(_ tag: String) {
        searchText = tag
        viewModel.filterListingsAndUsers(query: tag)
    }
}

// Updated CategoryIcon to include an action
struct CategoryIcon: View {
    let name: String
    let iconImage: Image
    let action: () -> Void
    
    var body: some View {
        Button(action: action) {
            VStack {
                ZStack {
                    Circle()
                        .fill(Color("LightestBlue"))
                        .frame(width: 74, height: 74)
                    iconImage
                        .resizable()
                        .scaledToFit()
                        .frame(width: 50, height: 40)
                }
                Text(name)
                    .font(.caption)
                    .foregroundColor(.primary)
            }
        }
    }
}

// SeasonalSection updated to accept action
struct SeasonalSection: View {
    let sectionImage: Image
    let title: String
    let action: () -> Void
    
    var body: some View {
        Button(action: action) {
            ZStack(alignment: .bottom) {
                sectionImage
                    .resizable()
                    .scaledToFill()
                    .frame(height: 150)
                    .clipShape(RoundedRectangle(cornerRadius: 50))
                    .overlay(
                        RoundedRectangle(cornerRadius: 50)
                            .fill(Color.black.opacity(0.1))
                    )
                Text(title)
                    .font(.title3)
                    .bold()
                    .foregroundColor(.white)
                    .shadow(color: .black.opacity(0.6), radius: 2, x: 0, y: 1)
                    .padding(.bottom, 10)
            }
            .padding(.horizontal, 10)
        }
    }
}
