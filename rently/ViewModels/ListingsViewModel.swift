//
//  ListingsViewModel.swift
//  rently
//
//  Created by Abby Chen on 11/2/24.
//

import Foundation
import Combine

class ListingsViewModel: ObservableObject {
    @Published var listings: [Listing] = []
    private var repository = ListingRepository()
    private var cancellables: Set<AnyCancellable> = []

    init() {
        repository.$listings
            .assign(to: \.listings, on: self)
            .store(in: &cancellables)
    }

    func fetchListings() {
        repository.fetchListings()
    }
    
    var listingsCount: Int {
        return listings.count
    }
    
    // CRUD will go here later
}

