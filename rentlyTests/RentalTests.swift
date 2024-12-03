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

    // MARK: - Test Firestore Decoding

    func testRentalDecodingFromFirestore() {
        // Add a rental document to Firestore for testing
        let rentalData: [String: Any] = [
            "renteeID": "user2",
            "renterID": "user1",
            "startDate": Timestamp(date: mockRental.startDate),
            "endDate": Timestamp(date: mockRental.endDate),
            "pickupLocation": mockRental.pickupLocation,
            "listingID": mockRental.listingID,
            "message": mockRental.message,
            "status": mockRental.status
        ]
        
        let rentalRef = db.collection("rentals").document("rental1")
        rentalRef.setData(rentalData) { error in
            XCTAssertNil(error, "Failed to set Firestore rental document")
        }
        
        // Retrieve and decode the rental document
        rentalRef.getDocument { (document, error) in
            XCTAssertNil(error, "Failed to get Firestore rental document")
            
            if let document = document, document.exists {
                do {
                    let rental = try document.data(as: Rental.self)
                    XCTAssertEqual(rental.renteeID, "user2", "Failed to decode renteeID")
                    XCTAssertEqual(rental.renterID, "user1", "Failed to decode renterID")
                    XCTAssertEqual(rental.pickupLocation, "Jared L. Cohon University Center", "Failed to decode pickupLocation")
                } catch {
                    XCTFail("Failed to decode Rental from Firestore: \(error)")
                }
            } else {
                XCTFail("Rental document does not exist")
            }
        }
    }

    func testListingDecodingFromFirestore() {
        // Add a listing document to Firestore for testing
        let listingData: [String: Any] = [
            "title": mockListing.title,
            "creationTime": Timestamp(date: mockListing.creationTime),
            "description": mockListing.description,
            "category": "womensTops",
            "userID": mockListing.userID,
            "size": "M",
            "price": mockListing.price,
            "color": "blue",
            "condition": "brandNew",
            "photoURLs": mockListing.photoURLs,
            "tags": ["casual", "vintage"],
            "brand": mockListing.brand,
            "maxRentalDuration": "oneWeek",
            "pickupLocations": ["uc"],
            "available": true
        ]
        
        let listingRef = db.collection("listings").document("listing1")
        listingRef.setData(listingData) { error in
            XCTAssertNil(error, "Failed to set Firestore listing document")
        }
        
        // Retrieve and decode the listing document
        listingRef.getDocument { (document, error) in
            XCTAssertNil(error, "Failed to get Firestore listing document")
            
            if let document = document, document.exists {
                do {
                    let listing = try document.data(as: Listing.self)
                    XCTAssertEqual(listing.title, "Cool Jacket", "Failed to decode title")
                    XCTAssertEqual(listing.userID, "user1", "Failed to decode userID")
                    XCTAssertEqual(listing.price, 25.0, "Failed to decode price")
                } catch {
                    XCTFail("Failed to decode Listing from Firestore: \(error)")
                }
            } else {
                XCTFail("Listing document does not exist")
            }
        }
    }

    func testUserHasListings() {
        // Test if the mock user has the expected listings
        XCTAssertTrue(mockUser.listings.contains("listing1"), "User's listings are incorrect")
    }
    
    func testRentalIsActiveOrUpcoming() {
        // Check if the rental is active or upcoming
        XCTAssertTrue(mockRental.isActiveOrUpcoming, "Rental should be active or upcoming")
    }
    
    func testDaysUntilPickup() throws {
        let pickupDate = Calendar.current.date(byAdding: .day, value: 3, to: Date())!
        let rental = Rental(renteeID: "user2", renterID: "user1", startDate: pickupDate, endDate: pickupDate.addingTimeInterval(86400), pickupLocation: "Location", listingID: "listing1", message: "Looking forward to the rental!", status: "active")
        
        // Now simply access the daysUntilPickup property
        let daysUntilPickup = rental.daysUntilPickup

        // Assert that the result is greater than 0
        XCTAssertGreaterThan(daysUntilPickup, 0, "Days until pickup should be greater than 0")
    }




}
