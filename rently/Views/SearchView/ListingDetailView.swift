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
                      Button(action: {
                      }) {
                          Text("rent")
                              .font(.headline)
                              .padding()
                              .frame(maxWidth: .infinity)
                              .background(Color.green.opacity(0.7))
                              .cornerRadius(10)
                              .foregroundColor(.white)
                            }
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

// MARK: - Preview Provider
struct ListingDetailView_Previews: PreviewProvider {
    static var previews: some View {
        let mockUser = User(
            id: "123",
            username: "johndoe",
            rating: 4.8,
            likedItems: [],
            listings: []
        )

        let mockListing = Listing(
            id: "1",
            title: "Stylish Jacket",
            description: "A beautiful jacket for every occasion.",
            price: 15.0,
            size: .medium,
            condition: .good,
            brand: "Zara",
            photoURLs: ["https://via.placeholder.com/150"],
            userID: "123"
        )

        return ListingDetailView(listingID: "1")
            .environmentObject(UserViewModel(user: mockUser))
            .environmentObject(ListingsViewModel(listings: [mockListing]))
    }
}
