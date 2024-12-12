//
//  HomeView.swift
//  rently
//

import Foundation
import SwiftUI

struct HomeView: View {
    @EnvironmentObject var userViewModel: UserViewModel
    @StateObject var searchViewModel = SearchViewModel() // Local search view model
    @State private var searchText = ""

  var body: some View {
    VStack {
      NavigationView {
        ScrollView {
          VStack(alignment: .leading, spacing: 20) {
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
            .padding(.horizontal)
            
            // Search Bar
            HStack {
              Image(systemName: "magnifyingglass")
                .foregroundColor(.black)
                .padding(.horizontal, 6)
              TextField("search for anything...", text: $searchText)
                .padding(8)
                .onChange(of: searchText) { newValue in
                  // Call the filter function in the view model
                  searchViewModel.filterListingsAndUsers(query: newValue)
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
            .padding(.horizontal)
            
            if !searchText.isEmpty {
              // Show relevant results based on search query
              List {
                Section(header: Text("listings")) {
                  ForEach(searchViewModel.listings) { listing in
                    NavigationLink(destination: ListingView(listing: listing).environmentObject(userViewModel)) {
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
                Section(header: Text("users")) {
                  ForEach(searchViewModel.users) { user in
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
            } else {
              // Default content if no search query is entered
              VStack(spacing: 30) {
                ZStack {
                  // Cloud image
                  Image("cloud")
                    .resizable()
                    .scaledToFit()
                    .frame(width: 350, height: 220)
                  
                  // Display "Hi, {firstName}" dynamically
                  Text("hi, \(userViewModel.user.firstName)!")
                    .font(.system(size: 32, weight: .bold))
                    .foregroundColor(.clear)
                    .overlay(
                      LinearGradient(
                        gradient: Gradient(colors: [Color("MediumBlue"), Color("MediumGreen")]),
                        startPoint: .leading,
                        endPoint: .trailing
                      )
                      .mask(
                        Text("hi, \(userViewModel.user.firstName)!")
                          .font(.system(size: 32, weight: .bold)) // Add mask for gradient
                      )
                    )
                }
                .frame(maxWidth: .infinity)
                
                // Sections
                ActiveRentalsView()
                SuggestedItemsView()
                TrendingSearchesView()
                
<<<<<<< HEAD
                // Show relevant results based on search query
                if !searchText.isEmpty {
                    List {
                        Section(header: Text("Listings")) {
                            ForEach(searchViewModel.listings) { listing in
                                NavigationLink(destination: ListingView(listing: listing).environmentObject(userViewModel)) { // Updated
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
                            ForEach(searchViewModel.users) { user in
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
                } else {
                    // Default content if no search query is entered
                    ScrollView {
                        VStack(spacing: 30) {
                            ActiveRentalsView() // Assuming this is a pre-existing view
                            SuggestedItemsView() // Assuming this is a pre-existing view
                            TrendingSearchesView() // Assuming this is a pre-existing view
                            
                            Spacer()
                        }
                        .padding(.horizontal)
                        .navigationBarHidden(true)
                    }
                }
            }
            .onAppear {
                // Fetch data on appear
                searchViewModel.fetchListings()
                searchViewModel.fetchUsers()
=======
                Spacer()
              }
              .padding(.horizontal)
>>>>>>> addd950 (updated ui of homepage)
            }
          }
          .navigationBarHidden(true)
        }
        .onAppear {
          // Fetch data on appear
          searchViewModel.fetchListings()
          searchViewModel.fetchUsers()
        }
      }
    }
  }
}
