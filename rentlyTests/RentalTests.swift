//
//  RentalTests.swift
//  rentlyTests
//
//  Created by Sara Riyad on 12/3/24.
//

import XCTest
import FirebaseFirestore
@testable import rently

class RentalTests: XCTestCase {

    var mockUser: User!
    var mockListing: Listing!
    var mockRental: Rental!
    var db: Firestore!

    override func setUp() {
        super.setUp()
        
        // Initialize Firestore
        db = Firestore.firestore()
        
        // Mock User Data
        mockUser = User(id: "user1", firstName: "Tishyaa", lastName: "Chaudhry", username: "tishyaa", pronouns: "she/her", email: "tishyaa@example.com", password: "password", university: "Carnegie Mellon", rating: 4.5, listings: ["listing1"], likedItems: [], styleChoices: [], events: [])
        
        // Mock Listing Data
        mockListing = Listing(id: "listing1", title: "Cool Jacket", creationTime: Date(), description: "A stylish jacket for every occasion", category: .womensTops, userID: "user1", size: .medium, price: 25.0, color: .blue, condition: .brandNew, photoURLs: ["photo1", "photo2"], tags: [.casual, .vintage], brand: "Brand X", maxRentalDuration: .oneWeek, pickupLocations: [.uc], available: true)
        
        // Mock Rental Data
        mockRental = Rental(id: "rental1", renteeID: "user2", renterID: "user1", startDate: Date().addingTimeInterval(86400), endDate: Date().addingTimeInterval(172800), pickupLocation: "Jared L. Cohon University Center", listingID: "listing1", message: "Looking forward to the rental!", status: "active")
    }
    
    override func tearDown() {
        mockUser = nil
        mockListing = nil
        mockRental = nil
        db = nil
        super.tearDown()
    }

    func testRentalIsActiveOrUpcoming() {
        XCTAssertTrue(mockRental.isActiveOrUpcoming, "Rental should be active or upcoming")
    }

    func testRentalStatusText() {
        // Arrange
        let calendar = Calendar.current
        mockRental.startDate = calendar.startOfDay(for: Date().addingTimeInterval(5 * 86400)) // Start 5 days from today
        mockRental.endDate = calendar.startOfDay(for: Date().addingTimeInterval(6 * 86400))  // End 6 days from today

        // Act
        let rentalStatus = mockRental.rentalStatusText

        // Assert
        XCTAssertEqual(rentalStatus, "5 days until pickup", "Rental status should reflect days until pickup")
    }


    func testDaysUntilPickupFutureStartDate() {
        // Arrange
        let calendar = Calendar.current
        let pickupDate = calendar.startOfDay(for: Date().addingTimeInterval(4 * 86400)) // Start 4 days from today
        mockRental.startDate = pickupDate

        // Act
        let daysUntilPickup = mockRental.daysUntilPickup

        // Assert
        XCTAssertEqual(daysUntilPickup, 4, "Days until pickup should be 4") // Correct expectation to match input
    }

}
