//
//  ListingTests.swift
//  rentlyTests
//
//  Created by Sara Riyad on 12/3/24.
//

import XCTest
import FirebaseFirestore
@testable import rently

class ListingTests: XCTestCase {
    var db: Firestore!

    override func setUp() {
        super.setUp()
        db = Firestore.firestore()
    }

    override func tearDown() {
        db = nil
        super.tearDown()
    }

    // Test Firestore Decoding for Listing
    func testListingDecoding() async throws {
        // Add a mock document to Firestore
        let collection = db.collection("listings")
        let documentRef = collection.document("mockListing1")
        
        let mockListingData: [String: Any] = [
            "title": "Cool Jacket",
            "creationTime": Timestamp(date: Date()),
            "description": "A stylish jacket for every occasion",
            "category": "Women's Tops",
            "userID": "user1",
            "size": "M",
            "price": 25.0,
            "color": "blue",
            "condition": "brand new",
            "photoURLs": ["photo1", "photo2"],
            "tags": ["vintage", "casual"],
            "brand": "Brand X",
            "maxRentalDuration": "1 week",
            "pickupLocations": ["Jared L. Cohon University Center"],
            "available": true
        ]

        try await documentRef.setData(mockListingData)

        // Retrieve and decode the document
        let snapshot = try await documentRef.getDocument()
        let decodedListing = try snapshot.data(as: Listing.self)

        // Assert decoded properties
        XCTAssertNotNil(decodedListing, "Decoded listing should not be nil")
        XCTAssertEqual(decodedListing.title, "Cool Jacket", "Title should match mock data")
        XCTAssertEqual(decodedListing.price, 25.0, "Price should match mock data")
        XCTAssertEqual(decodedListing.category, .womensTops, "Category should match mock data")
        XCTAssertTrue(decodedListing.available == true, "Availability should match mock data")
    }

    // Test Listing Properties
    func testListingProperties() {
        let mockListing = Listing(
            id: "listing1",
            title: "Cool Jacket",
            creationTime: Date(),
            description: "A stylish jacket for every occasion",
            category: .womensTops,
            userID: "user1",
            size: .medium,
            price: 25.0,
            color: .blue,
            condition: .brandNew,
            photoURLs: ["photo1", "photo2"],
            tags: [.vintage, .casual],
            brand: "Brand X",
            maxRentalDuration: .oneWeek,
            pickupLocations: [.uc],
            available: true
        )

        XCTAssertEqual(mockListing.title, "Cool Jacket", "Title should be 'Cool Jacket'")
        XCTAssertEqual(mockListing.size, .medium, "Size should be Medium")
        XCTAssertEqual(mockListing.color, .blue, "Color should be Blue")
        XCTAssertTrue(mockListing.available, "Listing should be available")
    }
}
