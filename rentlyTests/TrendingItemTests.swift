//
//  TrendingItemTests.swift
//  rentlyTests
//
//  Created by Sara Riyad on 12/3/24.
//

import XCTest
import FirebaseFirestore
@testable import rently

class TrendingItemTests: XCTestCase {
    var db: Firestore!

    override func setUp() {
        super.setUp()
        db = Firestore.firestore()
    }

    override func tearDown() {
        db = nil
        super.tearDown()
    }

    // Test Firestore Decoding for TrendingItem
    func testTrendingItemDecoding() async throws {
        // Add a mock document to Firestore
        let collection = db.collection("trendingItems")
        let documentRef = collection.document("mockTrendingItem1")

        let mockTrendingItemData: [String: Any] = [
            "name": "Stylish Jacket",
            "thumbnailUrl": "https://example.com/jacket.jpg",
            "priority": 1
        ]

        try await documentRef.setData(mockTrendingItemData)

        // Retrieve and decode the document
        let snapshot = try await documentRef.getDocument()
        let decodedTrendingItem = try snapshot.data(as: TrendingItem.self)

        // Assert decoded properties
        XCTAssertNotNil(decodedTrendingItem, "Decoded TrendingItem should not be nil")
        XCTAssertEqual(decodedTrendingItem.name, "Stylish Jacket", "Name should match mock data")
        XCTAssertEqual(decodedTrendingItem.priority, 1, "Priority should match mock data")
        XCTAssertEqual(decodedTrendingItem.thumbnailUrl, "https://example.com/jacket.jpg", "Thumbnail URL should match mock data")
    }

    // Test TrendingItem Model Properties
    func testTrendingItemProperties() {
        let mockTrendingItem = TrendingItem(
            id: "trendingItem1",
            name: "Elegant Dress",
            thumbnailUrl: "https://example.com/dress.jpg",
            priority: 2
        )

        XCTAssertEqual(mockTrendingItem.name, "Elegant Dress", "Name should be 'Elegant Dress'")
        XCTAssertEqual(mockTrendingItem.priority, 2, "Priority should be 2")
        XCTAssertEqual(mockTrendingItem.thumbnailUrl, "https://example.com/dress.jpg", "Thumbnail URL should match mock data")
    }

    // Test Firestore Write and Read for TrendingItem
    func testTrendingItemFirestoreWriteAndRead() async throws {
        let collection = db.collection("trendingItems")
        let documentRef = collection.document("mockTrendingItem2")

        let trendingItem = TrendingItem(
            id: nil, // Firestore will generate the ID
            name: "Cool Sneakers",
            thumbnailUrl: "https://example.com/sneakers.jpg",
            priority: 3
        )

        // Manually convert TrendingItem to a dictionary for writing
        let trendingItemData: [String: Any] = [
            "name": trendingItem.name,
            "thumbnailUrl": trendingItem.thumbnailUrl,
            "priority": trendingItem.priority
        ]

        // Write to Firestore
        try await documentRef.setData(trendingItemData)

        // Read back from Firestore
        let snapshot = try await documentRef.getDocument()
        let retrievedTrendingItem = try snapshot.data(as: TrendingItem.self)

        // Assert that written and retrieved data match
        XCTAssertEqual(retrievedTrendingItem.name, "Cool Sneakers", "Retrieved name should match")
        XCTAssertEqual(retrievedTrendingItem.priority, 3, "Retrieved priority should match")
        XCTAssertEqual(retrievedTrendingItem.thumbnailUrl, "https://example.com/sneakers.jpg", "Retrieved thumbnail URL should match")
    }

}
