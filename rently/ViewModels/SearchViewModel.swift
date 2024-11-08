//
//  SearchViewModel.swift
//  rently
//
//  Created by Sara Riyad on 11/2/24.
//

import Foundation
import Combine

class SearchViewModel: ObservableObject {
    @Published var searchText: String = ""
    @Published var filteredListings: [Listing] = []
    @Published var filteredUsers: [User] = []

    private var allListings: [Listing] = [] // Fetch all listings here
    private var allUsers: [User] = [] // Fetch all users here

    init() {
        loadListings()
        loadUsers()
    }

    func loadListings() {
        // Load your listings (mock data or from a service)
    }

    func loadUsers() {
        // Load your users (mock data or from a service)
    }

    func performSearch() {
        filteredListings = allListings.filter {
            $0.title.lowercased().contains(searchText.lowercased()) ||
            $0.category.rawValue.lowercased().contains(searchText.lowercased()) ||
            $0.size.rawValue.lowercased().contains(searchText.lowercased()) ||
            $0.color.rawValue.lowercased().contains(searchText.lowercased()) ||
            $0.brand.lowercased().contains(searchText.lowercased()) ||
            $0.tags.map { $0.rawValue.lowercased() }.contains(searchText.lowercased())
        }
        
        filteredUsers = allUsers.filter {
            $0.firstName.lowercased().contains(searchText.lowercased()) ||
            $0.lastName.lowercased().contains(searchText.lowercased()) ||
            $0.username.lowercased().contains(searchText.lowercased())
        }
    }

    func clearSearch() {
        searchText = ""
        filteredListings = []
        filteredUsers = []
    }
}
