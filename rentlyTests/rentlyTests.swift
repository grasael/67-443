//
//  rentlyTests.swift
//  rentlyTests
//
//  Created by Sara Riyad on 12/3/24.
//

import XCTest
@testable import rently

final class rentlyTests: XCTestCase {

    func testUserInitialization() {
        let user = User(
            id: "12345",
            firstName: "John",
            lastName: "Doe",
            username: "johndoe",
            pronouns: "he/him",
            email: "johndoe@example.com",
            password: "securepassword",
            university: "Carnegie Mellon University",
            rating: 4.5,
            listings: ["123", "456"],
            likedItems: ["789", "101"],
            styleChoices: ["vintage", "casual"],
            events: ["event1"]
        )
        
        XCTAssertNotNil(user.id)
        XCTAssertEqual(user.firstName, "John")
        XCTAssertEqual(user.listings.count, 2)
        XCTAssertTrue(user.styleChoices.contains("vintage"))
    }

    func testRentalCalculation() {
        let listing = Listing(
            id: "001",
            title: "Red Dress",
            creationTime: Date(),
            description: "A beautiful red dress",
            category: .dresses,
            userID: "user123",
            size: .medium,
            price: 20.0,
            color: .red,
            condition: .good,
            photoURLs: ["url1", "url2"],
            tags: [.vintage, .party],
            brand: "Gucci",
            maxRentalDuration: .oneWeek,
            pickupLocations: [.uc, .tepper],
            available: true
        )
        
        let rental = Rental(
            id: "rental001",
            renteeID: "user456",
            renterID: "user123",
            startDate: Date(),
            endDate: Calendar.current.date(byAdding: .day, value: 7, to: Date())!,
            pickupLocation: "UC",
            listingID: "001",
            message: "Looking forward to this rental!",
            status: "active"
        )
        
        let totalCost = rental.calculateTotalCost(for: listing)
        XCTAssertEqual(totalCost, 140.0) // Assuming 7 days * 20.0 per day
    }

    func testReviewModel() {
        let review = Review(
            id: "review001",
            condition: true,
            hasDamages: false,
            itemID: "123",
            rating: 5,
            rentalID: "rental123",
            text: "Amazing rental!",
            time: Date(),
            userID: "user001"
        )
        
        XCTAssertEqual(review.rating, 5)
        XCTAssertFalse(review.hasDamages)
        XCTAssertEqual(review.text, "Amazing rental!")
    }

    func testTrendingItemPriority() {
        let trendingItem = TrendingItem(
            id: "trend001",
            name: "Winter Coat",
            thumbnailUrl: "example.com/image.jpg",
            priority: 1
        )
        
        XCTAssertEqual(trendingItem.priority, 1)
        XCTAssertEqual(trendingItem.name, "Winter Coat")
    }

    func testListingTags() {
        let tags: [TagOption] = [.vintage, .formal, .casual]
        XCTAssertTrue(tags.contains(.formal))
        XCTAssertFalse(tags.contains(.party))
    }
}
