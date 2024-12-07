//
//  ListingDetailView.swift
//  rently
//
//  Created by Sara Riyad on 11/7/24.
//

import Foundation
import SwiftUI

struct ListingDetailView: View {
    let listingID: String
    @State private var showShareView = false
    @State private var showReportView = false
    @State private var showEditView = false
    @State private var showDeleteAlert = false
    @State private var showMenu = false
    
    @StateObject private var viewModel = ListingDetailViewModel()
    @EnvironmentObject var userViewModel: UserViewModel
    @EnvironmentObject var listingsViewModel: ListingsViewModel
    @Environment(\.dismiss) var dismiss
    @State private var isLiked: Bool = false

    var body: some View {
        VStack {
            if let listing = viewModel.listing {
                ScrollView {
                    VStack(alignment: .leading) {
                      // Header with User Info and Icons
                      HStack {
                          // Profile Icon
                          Image(systemName: "person.circle")
                              .resizable()
                              .frame(width: 40, height: 40)
                              .foregroundColor(.gray)

                          // Username and Rating
                          VStack(alignment: .leading) {
                            Text("\(userViewModel.user.username)")
                                  .font(.headline)
                                  .foregroundColor(.primary)

                              HStack(spacing: 2) {
                                  Image(systemName: "star.fill")
                                      .foregroundColor(.yellow)
                                      .font(.caption)
                                Text("\(String(format: "%.1f", userViewModel.user.rating))")
                                      .font(.subheadline)
                                      .foregroundColor(.gray)
                              }
                          }
                          .padding(.leading, 8)

                          Spacer()

                        // ellipsis Button
                        Menu {
                          if userViewModel.user.id == listing.userID {
                            Button("edit listing") {
                              showEditView = true
                            }
                            Button("share listing") {
                                showShareView = true
                            }
                            Button("delete listing") {
                                showDeleteAlert = true
                            }
                            .foregroundColor(.red)
                        } else {
                            Button("share listing") {
                                showShareView = true
                            }
                            Button("report listing") {
                                showReportView = true
                            }
                            .foregroundColor(.red)
                        }
                    } label: {
                        Image(systemName: "ellipsis")
                    }
                    .foregroundColor(.primary)
              }
              .padding([.horizontal, .top])

              // Main Image
              AsyncImage(url: URL(string: listing.photoURLs.first ?? "")) { image in
                  image.resizable()
                      .aspectRatio(contentMode: .fit)
                      .cornerRadius(10)
              } placeholder: {
                  ProgressView()
              }
              .padding(.horizontal)

              VStack(alignment: .leading, spacing: 8) {
                  Text(listing.title)
                      .font(.title2)
                      .bold()
                  HStack {
                      Text(listing.brand)
                          .font(.subheadline)
                          .padding(5)
                          .background(Color.blue.opacity(0.2))
                          .cornerRadius(8)
                    Text(listing.condition.rawValue)
                          .font(.subheadline)
                          .padding(5)
                          .background(Color.gray.opacity(0.2))
                          .cornerRadius(8)
                      Text("size \(listing.size.rawValue)")
                          .font(.subheadline)
                          .padding(5)
                          .background(Color.gray.opacity(0.2))
                          .cornerRadius(8)
                  }

                  Text(listing.description)
                      .font(.body)
                      .padding(.top, 5)
                  
                  Spacer()

                  HStack {
                      Text("$\(String(format: "%.2f", listing.price))/day")
                          .font(.headline)
                          .foregroundColor(.primary)
                      Spacer()

                                  // Rent Button with NavigationLink
                                  NavigationLink(destination: RentAnItemView(listing: listing)) {
                                      Text("Rent")
                                          .font(.headline)
                                          .frame(maxWidth: .infinity)
                                          .padding()
                                          .background(Color.blue)
                                          .foregroundColor(.white)
                                          .cornerRadius(8)
                                  }
                                  .padding(.top, 16)
                        }
                    }
                    .padding()
                        
                    Button(action: {
                        toggleLike(for: listing)
                    }) {
                        Image(systemName: isLiked ? "heart.fill" : "heart")
                            .font(.system(size: 24))
                            .foregroundColor(isLiked ? .red : .gray)
                    }
                    }
                }
            } else {
              ProgressView("Loading...")
        }
      }
        .onAppear {
            viewModel.fetchListing(by: listingID)
            checkIfLiked()
        }
        .navigationTitle("Listing Details")
        .navigationBarTitleDisplayMode(.inline)
        // Present Edit Listing View
        .sheet(isPresented: $showEditView) {
          if let listing = viewModel.listing {
            EditListingView(listing: listing)
              .environmentObject(listingsViewModel)
          }
        }
        
        // Present Delete Listing View
        .alert(isPresented: $showDeleteAlert) {
          Alert(
            title: Text("are you sure you want to delete this listing?"),
            message: Text("this action cannot be undone."),
            primaryButton: .destructive(Text("delete")) {
              if let listing = viewModel.listing, let id = listing.id {
                              print("Listing User ID: \(listing.userID), Current User ID: \(userViewModel.user.id ?? "nil")")
                              listingsViewModel.deleteListing(id) { result in
                                  switch result {
                                  case .success:
                                      print("Listing deleted successfully.")
                                      dismiss() // Dismiss view after successful deletion
                                  case .failure(let error):
                                      print("Error deleting listing: \(error.localizedDescription)")
                                  }
                              }
                          } else {
                              print("Error: Unable to retrieve listing or ID.")
                          }
            },
            secondaryButton: .cancel()
          )
        }
      
        // Present Share Listing View
        .sheet(isPresented: $showShareView) {
            NavigationView {
                ShareListingView()
            }
        }
        // Present Report Listing View
        .sheet(isPresented: $showReportView) {
            NavigationView {
                ReportListingView()
            }
        }
    }
    
    private func checkIfLiked() {
            if let listingID = viewModel.listing?.id {
                isLiked = userViewModel.user.likedItems.contains(listingID)
            }
        }
    
    private func toggleLike(for listing: Listing) {
        guard let listingID = listing.id else { return }
        
        if isLiked {
            userViewModel.user.likedItems.removeAll { $0 == listingID }
        } else {
            userViewModel.user.likedItems.append(listingID)
        }
        isLiked.toggle()
        userViewModel.updateUser()
    }
}

struct ListingDetailView_Previews: PreviewProvider {
    static var previews: some View {
        // Mock a sample listing
        let sampleListing = Listing(
            id: "1",
            title: "Sample Dress",
            creationTime: Date(),
            description: "A beautiful summer dress.",
            category: .womensTops,
            userID: "123", // Matches the mock user's ID
            size: .medium,
            price: 25.0,
            color: .blue,
            condition: .veryGood,
            photoURLs: ["https://via.placeholder.com/150"],
            tags: [.formal],
            brand: "Gucci",
            maxRentalDuration: .oneWeek,
            pickupLocations: [],
            available: true
        )
        
        // Mock User
        let mockUser = User(
            id: "123", // Matches the listing's userID
            firstName: "Grace",
            lastName: "Liao",
            username: "gracel",
            pronouns: "she/her",
            email: "grace@example.com",
            password: "password123",
            university: "Sample University",
            rating: 4.9,
            listings: ["1"], // Listing ID of the sample listing
            likedItems: [],
            styleChoices: ["Bohemian", "Chic"],
            events: [],
            followers: [],
            following: [],
            renting: [],
            myItems: []
        )
        
        // Initialize UserViewModel with the mock user
        let mockUserViewModel = UserViewModel(user: mockUser)
        
        // Mock ListingsViewModel
        let mockListingsViewModel = ListingsViewModel()
        mockListingsViewModel.listings = [sampleListing]
        
        return NavigationView {
            ListingDetailView(listingID: sampleListing.id ?? "")
                .environmentObject(mockUserViewModel)
                .environmentObject(mockListingsViewModel)
        }
    }
}
