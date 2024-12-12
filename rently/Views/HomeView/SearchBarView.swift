//
//  SearchBarView.swift
//  rently
//
//  Created by Tishyaa Chaudhry on 11/2/24.
//

import Foundation
import SwiftUI

// MARK: - SearchBarView
struct SearchBarView: View {
    @ObservedObject var userManager = UserManager.shared
    @ObservedObject var searchViewModel = SearchViewModel()
    @State private var searchText = ""

    var body: some View {
        VStack(alignment: .leading, spacing: 20) {
            // Search Bar
            HStack {
                Image(systemName: "magnifyingglass")
                    .foregroundColor(.gray)
                TextField("search for an item...", text: $searchText)
                    .padding(10)
                    .background(Color.white)
                    .cornerRadius(8)
                    .overlay(
                        RoundedRectangle(cornerRadius: 8)
                            .stroke(Color.gray.opacity(0.3), lineWidth: 1)
                    )
                    .onChange(of: searchText) { newValue in
                        searchViewModel.filterListingsAndUsers(query: newValue)
                    }
            }
            .padding(.horizontal)
            
            if !searchText.isEmpty {
                // Display search results
                List {
                    Section(header: Text("Listings")) {
                        ForEach(searchViewModel.listings) { listing in
                            NavigationLink(destination: ListingDetailView(listingID: listing.id ?? "")) {
                                HStack {
                                    AsyncImage(url: URL(string: listing.photoURLs.first ?? "")) { phase in
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
                                    }
                                    VStack(alignment: .leading) {
                                        Text(listing.title)
                                            .font(.headline)
                                        Text("$\(listing.price, specifier: "%.2f")")
                                            .font(.subheadline)
                                    }
                                }
                            }
                        }
                    }
                    
                    Section(header: Text("Users")) {
                        ForEach(searchViewModel.users) { user in
                            NavigationLink(destination: SearchUserDetailView(user: user)) {
                                UserProfileRow(user: user)
                            }
                        }
                    }
                }
                .scrollContentBackground(.hidden)
                .background(Color.white)
            } else {
                // Default background and greeting message
                ZStack {
                    Image("cloudBackground")
                        .resizable()
                        .scaledToFit()
                        .frame(maxWidth: .infinity, maxHeight: 150)
                        .opacity(0.3)
                        .edgesIgnoringSafeArea(.horizontal)
                    
                    Text("Hi, \(userManager.user?.firstName ?? "Guest")!")
                        .font(.largeTitle)
                        .foregroundColor(.green)
                        .padding()
                }
            }
        }
        .onAppear {
            // Ensure user data and initial listings are loaded
            searchViewModel.fetchListings()
            searchViewModel.fetchUsers()
        }
    }
}
