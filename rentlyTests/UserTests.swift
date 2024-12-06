//
//  UserTests.swift
//  rentlyTests
//
//  Created by Sara Riyad on 12/3/24.
//

import XCTest
import FirebaseFirestore
@testable import rently

class UserTests: XCTestCase {
    var db: Firestore!

    override func setUp() {
        super.setUp()
        db = Firestore.firestore()
    }

    override func tearDown() {
        db = nil
        super.tearDown()
    }

    // Test Firestore Decoding for User
    func testUserDecoding() async throws {
        // Add a mock document to Firestore
        let collection = db.collection("users")
        let documentRef = collection.document("mockUser1")
        
        let mockUserData: [String: Any] = [
            "firstName": "Alex",
            "lastName": "Johnson",
            "username": "alexj",
            "pronouns": "they/them",
            "email": "alex.johnson@example.com",
            "password": "securepassword123",
            "university": "Carnegie Mellon University",
            "rating": 4.5,
            "listings": ["listing1", "listing2"],
            "likedItems": ["item1", "item2"],
            "styleChoices": ["vintage", "casual"],
            "events": ["event1", "event2"]
        ]

        try await documentRef.setData(mockUserData)

        // Retrieve and decode the document
        let snapshot = try await documentRef.getDocument()
        let decodedUser = try snapshot.data(as: User.self)

        // Assert decoded properties
        XCTAssertNotNil(decodedUser, "Decoded user should not be nil")
        XCTAssertEqual(decodedUser.firstName, "Alex", "First name should match mock data")
        XCTAssertEqual(decodedUser.rating, 4.5, "Rating should match mock data")
        XCTAssertEqual(decodedUser.username, "alexj", "Username should match mock data")
        XCTAssertEqual(decodedUser.listings.count, 2, "Listings count should match mock data")
    }

    // Test User Model Properties
    func testUserProperties() {
        let mockUser = User(
            id: "user1",
            firstName: "Alex",
            lastName: "Johnson",
            username: "alexj",
            pronouns: "they/them",
            email: "alex.johnson@example.com",
            password: "securepassword123",
            university: "Carnegie Mellon University",
            rating: 4.5,
            listings: ["listing1", "listing2"],
            likedItems: ["item1", "item2"],
            styleChoices: ["vintage", "casual"],
            events: ["event1", "event2"]
        )

        XCTAssertEqual(mockUser.firstName, "Alex", "First name should be 'Alex'")
        XCTAssertEqual(mockUser.rating, 4.5, "Rating should be 4.5")
        XCTAssertEqual(mockUser.listings, ["listing1", "listing2"], "Listings should match the mock data")
        XCTAssertEqual(mockUser.styleChoices, ["vintage", "casual"], "Style choices should match mock data")
    }

    // Test Firestore Write and Read for User
    func testUserFirestoreWriteAndRead() async throws {
        let collection = db.collection("users")
        let documentRef = collection.document("mockUser2")
        
        let user = User(
            id: nil, // Firestore will generate the ID
            firstName: "Jordan",
            lastName: "Smith",
            username: "jordansmith",
            pronouns: "she/her",
            email: "jordan.smith@example.com",
            password: "mypassword",
            university: "CMU",
            rating: 4.8,
            listings: ["listing3", "listing4"],
            likedItems: ["item3", "item4"],
            styleChoices: ["edgy", "formal"],
            events: ["event3", "event4"]
        )
        
        // Write to Firestore
        try documentRef.setData(from: user)
        
        // Read back from Firestore
        let snapshot = try await documentRef.getDocument()
        let retrievedUser = try snapshot.data(as: User.self)
        
        // Assert that written and retrieved data match
        XCTAssertEqual(retrievedUser.username, "jordansmith", "Retrieved username should match")
        XCTAssertEqual(retrievedUser.email, "jordan.smith@example.com", "Retrieved email should match")
        XCTAssertEqual(retrievedUser.styleChoices, ["edgy", "formal"], "Style choices should match")
    }
}
