//
//  ListingDetailView.swift
//  rently
//
//  Created by Sara Riyad on 11/7/24.
//
import SwiftUI

struct ListingDetailView: View {
    let listing: Listing
    let user: User

    var body: some View {
        VStack {
            ScrollView {
                VStack(alignment: .leading) {
                    // User and Rating Information
                    HStack(spacing: 10) {
                        // User's profile image placeholder
                        Circle()
                            .fill(Color.gray)
                            .frame(width: 50, height: 50)

                        VStack(alignment: .leading) {
                            Text(user.username)
                                .font(.headline)
                            HStack(spacing: 2) {
                                ForEach(0..<5) { star in
                                    Image(systemName: star < Int(user.rating) ? "star.fill" : "star")
                                        .foregroundColor(star < Int(user.rating) ? .yellow : .gray)
                                }
                            }
                        }
                        
                        Spacer()
                        
                        // Three-Dots Menu
                        Menu {
                            Button("Edit Listing") {
                                editListing()
                            }
                            Button("Share Listing") {
                                shareListing()
                            }
                            Button("Delete Listing", role: .destructive) {
                                deleteListing()
                            }
                        } label: {
                            Image(systemName: "ellipsis")
                                .font(.title)
                                .foregroundColor(.black)
                        }
                    }
                    .padding(.horizontal)

                    // Listing Image
                    if let urlString = listing.photoURLs.first, let url = URL(string: urlString) {
                        AsyncImage(url: url) { image in
                            image
                                .resizable()
                                .aspectRatio(contentMode: .fit)
                                .cornerRadius(10)
                                .clipped()
                        } placeholder: {
                            ProgressView()
                        }
                    }

                    // Listing Details
                    Text(listing.title)
                        .font(.title)
                        .bold()
                        .padding(.horizontal)

                    HStack {
                        Text(listing.brand)
                            .font(.subheadline)
                            .padding(5)
                            .background(Color.blue.opacity(0.2))
                            .cornerRadius(5)
                        Text(listing.condition)
                            .font(.subheadline)
                            .padding(5)
                            .background(Color.gray.opacity(0.2))
                            .cornerRadius(5)
                        Text(listing.category.rawValue)
                            .font(.subheadline)
                            .padding(5)
                            .background(Color.gray.opacity(0.2))
                            .cornerRadius(5)
                        Text("size \(listing.size.rawValue)")
                            .font(.subheadline)
                            .padding(5)
                            .background(Color.gray.opacity(0.2))
                            .cornerRadius(5)
                    }
                    .padding(.horizontal)

                    Text(listing.description)
                        .padding(.horizontal)

                    HStack {
                        Text("$\(String(format: "%.2f", listing.price))/day")
                            .font(.headline)
                        Spacer()
                        if listing.available {
                            Button(action: {
                                // Rent action here
                            }) {
                                Text("Rent")
                                    .padding()
                                    .background(Color.green)
                                    .foregroundColor(.white)
                                    .cornerRadius(10)
                            }
                        } else {
                            Text("Rented until \(formattedDate(listing.creationTime))")
                                .foregroundColor(.gray)
                        }
                    }
                    .padding(.horizontal)
                    .padding(.top)
                }
            }

            // Bottom Tab Bar
            AppView()
                .frame(height: 70)
        }
        .navigationTitle("Listing Details")
        .navigationBarTitleDisplayMode(.inline)
    }
    
    // Helper functions for menu actions
    private func editListing() {
        print("Edit Listing tapped")
        // Add your edit listing logic here
    }

    private func shareListing() {
        print("Share Listing tapped")
        // Add your share listing logic here
    }

    private func deleteListing() {
        print("Delete Listing tapped")
        // Add your delete listing logic here
    }
    
    // Helper function to format the date
    private func formattedDate(_ date: Date) -> String {
        let formatter = DateFormatter()
        formatter.dateStyle = .short
        return formatter.string(from: date)
    }
}

struct ListingDetailView_Previews: PreviewProvider {
    static var previews: some View {
        ListingDetailView(listing: sampleListings[2], user: sampleUsers[0])
    }
}
