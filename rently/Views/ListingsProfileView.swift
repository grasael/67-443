//
//  ListingsProfileView.swift
//  rently
//
//  Created by Grace Liao on 11/8/24.
//
// These are just all the ones inside of Firebase for testing purposes only... need to filter for a specific user later
import SwiftUI

struct ListingsProfileView: View {
    @StateObject private var viewModel = ListingsViewModel() // Using the provided ViewModel
    
    var body: some View {
        NavigationView {
            List(viewModel.listings) { listing in
                Text(listing.title) // Display only the title
            }
            .onAppear {
                viewModel.fetchListings() // Fetch listings when the view appears
            }
            .navigationTitle("Listings")
        }
    }
}
