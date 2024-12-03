//
//  ReviewTests.swift
//  rentlyTests
//
//  Created by Sara Riyad on 12/3/24.
//

import XCTest
import FirebaseFirestore
@testable import rently

class ReviewTests: XCTestCase {
    var db: Firestore!

    override func setUp() {
        super.setUp()
        db = Firestore.firestore()
    }

    override func tearDown() {
        db = nil
        super.tearDown()
    }

    // Test Firestore Decoding for Review
    func testReviewDecoding() async throws {
        // Add a mock document to Firestore
        let collection = db.collection("reviews")
        let documentRef = collection.document("mockReview1")

        let mockReviewData: [String: Any] = [
            "condition": true,
            "hasDamages": false,
            "itemID": "item123",
            "rating": 5,
            "rentalID": "rental456",
            "text": "Great experience renting this item!",
            "time": Timestamp(date: Date()),
            "userID": "user789"
        ]

        try await documentRef.setData(mockReviewData)

        // Retrieve and decode the document
        let snapshot = try await documentRef.getDocument()
        let decodedReview = try snapshot.data(as: Review.self)

        // Assert decoded properties
        XCTAssertNotNil(decodedReview, "Decoded Review should not be nil")
        XCTAssertEqual(decodedReview.condition, true, "Condition should match mock data")
        XCTAssertEqual(decodedReview.hasDamages, false, "HasDamages should match mock data")
        XCTAssertEqual(decodedReview.itemID, "item123", "ItemID should match mock data")
        XCTAssertEqual(decodedReview.rating, 5, "Rating should match mock data")
        XCTAssertEqual(decodedReview.rentalID, "rental456", "RentalID should match mock data")
        XCTAssertEqual(decodedReview.text, "Great experience renting this item!", "Text should match mock data")
        XCTAssertEqual(decodedReview.userID, "user789", "UserID should match mock data")
    }

    // Test Review Model Properties
    func testReviewProperties() {
        let mockReview = Review(
            id: "review001",
            condition: false,
            hasDamages: true,
            itemID: "item001",
            rating: 3,
            rentalID: "rental001",
            text: "Item had minor damages but was usable.",
            time: Date(),
            userID: "user001"
        )

        XCTAssertEqual(mockReview.condition, false, "Condition should be false")
        XCTAssertEqual(mockReview.hasDamages, true, "HasDamages should be true")
        XCTAssertEqual(mockReview.itemID, "item001", "ItemID should be 'item001'")
        XCTAssertEqual(mockReview.rating, 3, "Rating should be 3")
        XCTAssertEqual(mockReview.rentalID, "rental001", "RentalID should be 'rental001'")
        XCTAssertEqual(mockReview.text, "Item had minor damages but was usable.", "Text should match mock data")
        XCTAssertEqual(mockReview.userID, "user001", "UserID should match mock data")
    }

    // Test Firestore Write and Read for Review
    func testReviewFirestoreWriteAndRead() async throws {
        let collection = db.collection("reviews")
        let documentRef = collection.document("mockReview2")

        let review = Review(
            id: nil, // Firestore will generate the ID
            condition: true,
            hasDamages: false,
            itemID: "item002",
            rating: 4,
            rentalID: "rental002",
            text: "Good quality and timely return.",
            time: Date(),
            userID: "user002"
        )

        // Write to Firestore
        try documentRef.setData(from: review)

        // Read back from Firestore
        let snapshot = try await documentRef.getDocument()
        let retrievedReview = try snapshot.data(as: Review.self)

        // Assert that written and retrieved data match
        XCTAssertEqual(retrievedReview.condition, true, "Retrieved condition should match")
        XCTAssertEqual(retrievedReview.hasDamages, false, "Retrieved hasDamages should match")
        XCTAssertEqual(retrievedReview.itemID, "item002", "Retrieved itemID should match")
        XCTAssertEqual(retrievedReview.rating, 4, "Retrieved rating should match")
        XCTAssertEqual(retrievedReview.rentalID, "rental002", "Retrieved rentalID should match")
        XCTAssertEqual(retrievedReview.text, "Good quality and timely return.", "Retrieved text should match")
        XCTAssertEqual(retrievedReview.userID, "user002", "Retrieved userID should match")
    }
}
