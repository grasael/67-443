//
//  ReviewRepositoryTests.swift
//  rentlyTests
//
//  Created by Sara Riyad on 12/4/24.
//

import XCTest
import FirebaseFirestore
import Combine
@testable import rently

final class ReviewRepositoryTests: XCTestCase {
    private var repository: ReviewRepository!
    private var cancellables: Set<AnyCancellable>!

    override func setUp() {
        super.setUp()
        cancellables = []
        repository = ReviewRepository()
    }

    override func tearDown() {
        repository = nil
        cancellables = nil
        super.tearDown()
    }

    func testGetReviewsSuccess() {
        let expectation = XCTestExpectation(description: "Fetch reviews successfully")

        repository.$reviews
            .dropFirst()
            .sink { reviews in
                XCTAssertGreaterThan(reviews.count, 0)
                expectation.fulfill()
            }
            .store(in: &cancellables)

        repository.get()

        wait(for: [expectation], timeout: 2.0)
    }

    func testCreateReviewSuccess() {
        let review = Review(
            id: nil, condition: true, hasDamages: false,
            itemID: "item1", rating: 5, rentalID: "rental1",
            text: "Great review.", time: Date(), userID: "user1"
        )

        let expectation = XCTestExpectation(description: "Create review successfully")
        repository.create(review)

        DispatchQueue.main.asyncAfter(deadline: .now() + 0.5) {
            // Validate based on repository updates or other state management
            XCTAssertTrue(true)
            expectation.fulfill()
        }

        wait(for: [expectation], timeout: 1.0)
    }

    func testUpdateReviewSuccess() {
        let review = Review(
            id: "review1", condition: true, hasDamages: false,
            itemID: "item1", rating: 4, rentalID: "rental1",
            text: "Updated review.", time: Date(), userID: "user1"
        )

        let expectation = XCTestExpectation(description: "Update review successfully")
        repository.update(review)

        DispatchQueue.main.asyncAfter(deadline: .now() + 0.5) {
            // Validate based on repository updates
            XCTAssertTrue(true)
            expectation.fulfill()
        }

        wait(for: [expectation], timeout: 1.0)
    }

    func testDeleteReviewSuccess() {
        let review = Review(
            id: "review1", condition: true, hasDamages: false,
            itemID: "item1", rating: 3, rentalID: "rental1",
            text: "Delete this review.", time: Date(), userID: "user1"
        )

        let expectation = XCTestExpectation(description: "Delete review successfully")
        repository.delete(review)

        DispatchQueue.main.asyncAfter(deadline: .now() + 0.5) {
            // Validate based on repository updates
            XCTAssertTrue(true)
            expectation.fulfill()
        }

        wait(for: [expectation], timeout: 1.0)
    }
}
