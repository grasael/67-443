//
//  ActiveRentalsViewModelTests.swift
//  rentlyTests
//
//  Created by Sara Riyad on 12/5/24.
//

import XCTest
import Combine
@testable import rently

final class ActiveRentalsViewModelTests: XCTestCase {
    var viewModel: ActiveRentalsViewModel!
    var firestoreMock: FirestoreMock!

    override func setUp() {
        super.setUp()
        firestoreMock = FirestoreMock()
        viewModel = ActiveRentalsViewModel()
    }

    override func tearDown() {
        viewModel = nil
        firestoreMock = nil
        super.tearDown()
    }

    func testFetchActiveRentalsSuccess() {
        let mockRentals: [[String: Any]] = [
            ["id": "1", "renterID": "u1", "listingID": "l1", "isActive": true],
            ["id": "2", "renterID": "u2", "listingID": "l2", "isActive": false]
        ]
        let snapshots = mockRentals.map { TestMockQueryDocumentSnapshot(data: $0) }
        let querySnapshot = TestMockQuerySnapshot(documents: snapshots)

        firestoreMock.mockQuery("Rentals", snapshot: querySnapshot)

        let expectation = self.expectation(description: "Fetching active rentals")
        viewModel.fetchActiveRentals()

        // Ensure the async fetch finishes
        DispatchQueue.main.asyncAfter(deadline: .now() + 0.1) {
            XCTAssertEqual(self.viewModel.rentals.count, 1)  // Check that we have only 1 active rental
            XCTAssertEqual(self.viewModel.rentals.first?.id, "1")  // Ensure the first rental has id "1"
            expectation.fulfill()
        }
        waitForExpectations(timeout: 1, handler: nil)
    }

    func testLoadRenterDetailsSuccess() {
        let mockUser: [String: Any] = ["id": "u1", "username": "TestUser"]
        firestoreMock.mockDocument("Users/u1", snapshot: mockUser)

        let mockRental = Rental(
            id: "r1", renteeID: "rentee1", renterID: "u1",
            startDate: Date(), endDate: Date(),
            pickupLocation: "Location", listingID: "listing1",
            message: "Message", status: "active"
        )

        let expectation = self.expectation(description: "Loading renter details")
        viewModel.loadRenterDetails(rental: mockRental)

        DispatchQueue.main.asyncAfter(deadline: .now() + 0.1) {
            XCTAssertNotNil(self.viewModel.renter)  // Ensure renter is not nil
            XCTAssertEqual(self.viewModel.renter?.username, "TestUser")  // Ensure the username matches
            expectation.fulfill()
        }

        waitForExpectations(timeout: 1, handler: nil)
    }

    func testLoadListingDetailsSuccess() {
        let mockListing: [String: Any] = ["id": "l1", "title": "Test Listing"]
        firestoreMock.mockDocument("Listings/l1", snapshot: mockListing)

        let mockRental = Rental(
            id: "r1", renteeID: "rentee1", renterID: "u1",
            startDate: Date(), endDate: Date(),
            pickupLocation: "Location", listingID: "l1",
            message: "Message", status: "active"
        )

        let expectation = self.expectation(description: "Loading listing details")
        viewModel.loadListingDetails(rental: mockRental)

        DispatchQueue.main.asyncAfter(deadline: .now() + 0.1) {
            XCTAssertNotNil(self.viewModel.listing)  // Ensure listing is not nil
            XCTAssertEqual(self.viewModel.listing?.title, "Test Listing")  // Ensure the title matches
            expectation.fulfill()
        }

        waitForExpectations(timeout: 1, handler: nil)
    }
}
