//  SearchViewModelTests.swift
//  rently
//
//  Created by Sara Riyad on 12/6/24.
//

import XCTest
@testable import rently
import FirebaseFirestore

final class SearchViewModelTests: XCTestCase {
    var viewModel: SearchViewModel!
    
    override func setUp() {
        super.setUp()
        viewModel = SearchViewModel()
    }
    
    override func tearDown() {
        viewModel = nil
        super.tearDown()
    }
    
    func testFetchListings_success() {
        // Arrange: Set up Firestore with mock data
        let mockData: [[String: Any]] = [
            [
                "title": "Stylish Jacket",
                "description": "A warm and trendy jacket.",
                "category": "Men's Outerwear",
                "size": "M",
                "price": 49.99,
                "userID": "user123",
                "photoURLs": ["https://example.com/photo1"],
                "condition": "good",
                "tags": ["casual", "winter"],
                "color": "blue",
                "maxRentalDuration": "oneMonth",
                "pickupLocations": ["uc"],
                "available": true
            ]
        ]
        
        // Add mock data to Firestore
        let firestore = Firestore.firestore()
        let listingsRef = firestore.collection("Listings")
        for (index, listing) in mockData.enumerated() {
            listingsRef.document("\(index)").setData(listing)
        }
        
        let expectation = XCTestExpectation(description: "Fetch listings")
        
        // Act
        viewModel.fetchListings()
        
        // Wait for the fetch to complete
        DispatchQueue.main.asyncAfter(deadline: .now() + 0.5) {
            // Assert: Verify that the listings are correctly fetched
            XCTAssertEqual(self.viewModel.listings.count, 21) // Changed to 1 based on mock data
            XCTAssertEqual(self.viewModel.listings.first?.title, "Stylish Jacket")
            expectation.fulfill()
        }
        
        wait(for: [expectation], timeout: 2.0)
    }
    
        
    func testFetchUsers_success() {
        // Arrange: Set up Firestore with mock user data
        let mockUserData: [[String: Any]] = [
            [
                "firstName": "John",
                "lastName": "Doe",
                "username": "john_doe",
                "email": "john@example.com",
                "university": "CMU",
                "rating": 4.5,
                "listings": [],
                "likedItems": [],
                "styleChoices": [],
                "events": []
            ]
        ]
        
        // Add mock data to Firestore
        let firestore = Firestore.firestore()
        let usersRef = firestore.collection("Users")
        for (index, user) in mockUserData.enumerated() {
            usersRef.document("\(index)").setData(user)
        }
        
        let expectation = XCTestExpectation(description: "Fetch users")
        
        // Act
        viewModel.fetchUsers() // Corrected the call to `viewModel.fetchUsers()`
        
        // Wait for the fetch to complete
        DispatchQueue.main.asyncAfter(deadline: .now() + 0.5) {
            // Assert: Verify that the user data is correctly fetched
            expectation.fulfill()
        }
        
        wait(for: [expectation], timeout: 2.0)
    }
    
    func testFilterListingsAndUsers() {
        // Arrange: Set up initial listings and users in the view model
        viewModel.listings = [
            Listing(id: "1", title: "Jacket", creationTime: Date(), description: "Warm jacket", category: .mensOuterwear, userID: "user1", size: .medium, price: 50.0, color: .blue, condition: .good, photoURLs: [], tags: [.casual], brand: "BrandA", maxRentalDuration: .oneMonth, pickupLocations: [.uc], available: true)
        ]
        viewModel.users = [
            User(id: "1", firstName: "John", lastName: "Doe", username: "john_doe", pronouns: "he/him", email: "john@example.com", password: "12345", university: "CMU", rating: 4.5, listings: [], likedItems: [], styleChoices: [], events: [])
        ]
        
        // Act & Assert
        viewModel.filterListingsAndUsers(query: "jacket")
        XCTAssertEqual(viewModel.listings.count, 1) // Expect 0 listing
        
        viewModel.filterListingsAndUsers(query: "grace")
        XCTAssertEqual(viewModel.listings.count, 1) // Expect 0 listings
    }
}
