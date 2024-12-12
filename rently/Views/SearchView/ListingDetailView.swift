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
                                if let user = UserManager.shared.user {
                                    Text("\(user.username)")
                                        .font(.headline)
                                        .foregroundColor(.primary)

                                    HStack(spacing: 2) {
                                        Image(systemName: "star.fill")
                                            .foregroundColor(.yellow)
                                            .font(.caption)
                                        Text("\(String(format: "%.1f", user.rating))")
                                            .font(.subheadline)
                                            .foregroundColor(.gray)
                                    }
                                }
                            }
                            .padding(.leading, 8)

                            Spacer()

                            // ellipsis Button
                            Menu {
                                if UserManager.shared.user?.id == listing.userID {
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

                      
                           // Title and Price
                           Text(listing.title)
                               .font(.title)
                               .fontWeight(.bold)
                           
                           Text("$\(String(format: "%.2f", listing.price)) / day")
                               .font(.headline)
                               .foregroundColor(.green)
                           
                           // Brand and Condition
                           HStack {
                               Text(listing.brand)
                                   .font(.subheadline)
                                   .foregroundColor(.secondary)
                               Spacer()
                               Text(listing.condition.rawValue.capitalized)
                                   .font(.subheadline)
                                   .padding(4)
                                   .background(Color.gray.opacity(0.2))
                                   .cornerRadius(4)
                           }
                           
                           // Description
                           Text(listing.description)
                               .font(.body)
                               .padding(.top, 8)

                           // Size, Color, and Tags
                           HStack {
                               Text("Size: \(listing.size.rawValue)")
                               Text("Color: \(listing.color.rawValue.capitalized)")
                           }
                           .font(.subheadline)
                           .foregroundColor(.secondary)

                           // Tags
                           if !listing.tags.isEmpty {
                               HStack {
                                   ForEach(listing.tags, id: \.self) { tag in
                                       Text(tag.rawValue.capitalized)
                                           .padding(4)
                                           .background(Color.blue.opacity(0.1))
                                           .cornerRadius(4)
                                   }
                               }
                           }

                           // Rental Duration and Pickup Locations
                           Text("Max Rental Duration: \(listing.maxRentalDuration.rawValue)")
                               .font(.subheadline)
                               .padding(.top, 8)
                           
                           Text("Pickup Locations:")
                               .font(.headline)
                               .padding(.top, 8)
                           
                           ForEach(listing.pickupLocations, id: \.self) { location in
                               Text(location.rawValue)
                                   .font(.subheadline)
                                   .foregroundColor(.secondary)
                           }
                           
                           Spacer()
                  
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
                title: Text("Are you sure you want to delete this listing?"),
                message: Text("This action cannot be undone."),
                primaryButton: .destructive(Text("Delete")) {
                    if let listing = viewModel.listing, let id = listing.id {
                        listingsViewModel.deleteListing(id) { result in
                            switch result {
                            case .success:
                                dismiss() // Dismiss view after successful deletion
                            case .failure(let error):
                                print("Error deleting listing: \(error.localizedDescription)")
                            }
                        }
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
            isLiked = UserManager.shared.user?.likedItems.contains(listingID) ?? false
        }
    }
    
    private func toggleLike(for listing: Listing) {
        guard let listingID = listing.id else { return }
        
        if var likedItems = UserManager.shared.user?.likedItems {
            if isLiked {
                likedItems.removeAll { $0 == listingID }
            } else {
                if !likedItems.contains(listingID) {
                    likedItems.append(listingID)
                }
            }
            isLiked.toggle()
            
            if var updatedUser = UserManager.shared.user {
                updatedUser.likedItems = likedItems
                UserManager.shared.saveUser(updatedUser)
            }
        }
    }
}
