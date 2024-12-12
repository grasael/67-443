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
                    VStack(alignment: .leading, spacing: 16) {
                        // Header with User Info and Icons
                        HStack {
                            // Profile Icon
                            Image(systemName: "person.circle")
                                .resizable()
                                .frame(width: 40, height: 40)
                                .foregroundColor(.gray)

                            // Username and Rating
                            VStack(alignment: .leading) {
                                Text(userViewModel.user.username)
                                    .font(.headline)
                                    .foregroundColor(.primary)

                                HStack(spacing: 2) {
                                    Image(systemName: "star.fill")
                                        .foregroundColor(.yellow)
                                        .font(.caption)
                                    Text(String(format: "%.1f", userViewModel.user.rating))
                                        .font(.subheadline)
                                        .foregroundColor(.gray)
                                }
                            }
                            .padding(.leading, 8)

                            Spacer()

                            // Ellipsis Button
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

                        // Image Carousel
                        TabView {
                            ForEach(listing.photoURLs, id: \.self) { photoURL in
                                AsyncImage(url: URL(string: photoURL)) { phase in
                                    switch phase {
                                    case .empty:
                                        ProgressView()
                                            .frame(maxWidth: .infinity, maxHeight: 340)
                                    case .success(let image):
                                        image
                                            .resizable()
                                            .scaledToFit()
                                            .cornerRadius(10)
                                            .frame(maxWidth: .infinity, maxHeight: 340)
                                    case .failure:
                                        Image("sampleItemImage") // Fallback image
                                            .resizable()
                                            .scaledToFit()
                                            .cornerRadius(10)
                                            .frame(maxWidth: .infinity, maxHeight: 340)
                                    @unknown default:
                                        EmptyView()
                                    }
                                }
                            }
                        }
                        .frame(height: 340)
                        .tabViewStyle(PageTabViewStyle(indexDisplayMode: .automatic))
                        .padding(.horizontal)

                        // Title and Like Button
                        HStack {
                            Text(listing.title)
                                .font(.title2)
                                .bold()
                                .lineLimit(1)
                                .foregroundColor(.black)
                            Spacer()
                            Button(action: {
                                toggleLike(for: listing)
                            }) {
                                Image(systemName: isLiked ? "heart.fill" : "heart")
                                    .font(.system(size: 24))
                                    .foregroundColor(isLiked ? .red : .gray)
                            }
                        }
                        .padding(.horizontal)
                        .padding(.bottom, 4)

                        // Listing Details
                        HStack {
                            Text(listing.brand)
                                .font(.subheadline)
                                .padding(.horizontal, 8)
                                .padding(.vertical, 4)
                                .background(Color.blue.opacity(0.2))
                                .cornerRadius(20)

                            Text(listing.condition.rawValue)
                                .font(.subheadline)
                                .padding(.horizontal, 8)
                                .padding(.vertical, 4)
                                .background(Color.gray.opacity(0.2))
                                .cornerRadius(20)

                            Text("size \(listing.size.rawValue)")
                                .font(.subheadline)
                                .padding(.horizontal, 8)
                                .padding(.vertical, 4)
                                .background(Color.gray.opacity(0.2))
                                .cornerRadius(20)
                        }
                        .padding(.horizontal)
                      
                        // Description
                        Text(listing.description)
                            .font(.body)
                            .padding(.horizontal)

                        // Tags
                        if !listing.tags.isEmpty {
                            HStack(spacing: 8) {
                                ForEach(listing.tags.prefix(3), id: \.self) { tag in
                                    Text(tag.rawValue)
                                        .font(.caption)
                                        .padding(.horizontal, 8)
                                        .padding(.vertical, 4)
                                        .background(Color.blue.opacity(0.1))
                                        .cornerRadius(20)
                                }
                            }
                            .padding(.horizontal)
                        }

                        // Price and Rent Button
                        HStack {
                            Text("$\(String(format: "%.2f", listing.price))/day")
                                .font(.headline)
                                .foregroundColor(.primary)
                            Spacer()
                            Button(action: {
                                // Rent button
                            }) {
                                Text("rent")
                                    .font(.headline)
                                    .padding()
                                    .frame(maxWidth: .infinity)
                                    .background(
                                        LinearGradient(
                                            gradient: Gradient(colors: [Color("MediumBlue"), Color("LightGreen")]),
                                            startPoint: .leading,
                                            endPoint: .trailing
                                        )
                                    )
                                    .cornerRadius(40)
                                    .foregroundColor(.white)
                            }
                        }
                        .padding(.horizontal)
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
        .navigationTitle("listing details")
        .navigationBarTitleDisplayMode(.inline)
        // Edit Listing Sheet
        .sheet(isPresented: $showEditView) {
            if let listing = viewModel.listing {
                EditListingView(listing: listing)
                    .environmentObject(listingsViewModel)
            }
        }
        // Delete Alert
        .alert(isPresented: $showDeleteAlert) {
            Alert(
                title: Text("are you sure you want to delete this listing?"),
                message: Text("this action cannot be undone."),
                primaryButton: .destructive(Text("delete")) {
                    if let listing = viewModel.listing, let id = listing.id {
                        listingsViewModel.deleteListing(id) { result in
                            switch result {
                            case .success:
                                dismiss()
                            case .failure(let error):
                                print("Error deleting listing: \(error.localizedDescription)")
                            }
                        }
                    }
                },
                secondaryButton: .cancel()
            )
        }
        // Share Listing Sheet
        .sheet(isPresented: $showShareView) {
            NavigationView {
                ShareListingView()
            }
        }
        // Report Listing Sheet
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
