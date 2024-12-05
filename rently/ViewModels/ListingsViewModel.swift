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
    
    func fetchListings(for userID: String) {
        repository.fetchListings(for: userID)
            .sink(receiveCompletion: { completion in
                if case .failure(let error) = completion {
                    print("Error fetching listings for user: \(error)")
                }
            }, receiveValue: { [weak self] listings in
                self?.listings = listings
            })
            .store(in: &cancellables)
    }
    
    var listingsCount: Int {
        return listings.count
    }
    
    //CRUD will go here later
}

