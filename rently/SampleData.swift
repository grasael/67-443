//
//  SampleData.swift
//  rently
//
//  Created by Sara Riyad on 11/7/24.
//

import Foundation

// Sample Users
let sampleUsers = [
    User(id: "user1",
         firstName: "Alice",
         lastName: "Johnson",
         username: "alicej",
         pronouns: "She/Her",
         email: "alice.johnson@example.com",
         password: "password123",
         university: "Carnegie Mellon University",
         rating: 4.8,
         listings: ["listing1", "listing2"],
         likedItems: ["listing3"],
         styleChoices: ["vintage", "casual"],
         events: ["concert", "party"]),
    
    User(id: "user2",
         firstName: "Bob",
         lastName: "Smith",
         username: "bobsmith",
         pronouns: "He/Him",
         email: "bob.smith@example.com",
         password: "password123",
         university: "University of Pittsburgh",
         rating: 4.5,
         listings: ["listing3"],
         likedItems: ["listing1", "listing2"],
         styleChoices: ["formal", "business"],
         events: ["graduation", "classy"])
]

// Sample Listings
let sampleListings = [
    Listing(
        id: UUID(),
        title: "Vintage Denim Jacket",
        creationTime: Date(),
        description: "A stylish vintage denim jacket, perfect for casual and streetwear looks.",
        category: .womensOuterwear,
        size: .medium,
        price: 25.00,
        color: .blue,
        condition: "Good",
        photoURLs: ["https://m.media-amazon.com/images/I/81EKqO6ltsL._AC_SY879_.jpg"],
        tags: [.vintage, .casual, .streetwear],
        brand: "Levi's",
        maxRentalDuration: .oneMonth,
        pickupLocation: .uc,
        available: true,
        rating: 4.7
    ),
    
    Listing(
        id: UUID(),
        title: "Formal Black Blazer",
        creationTime: Date(),
        description: "A sleek black blazer suitable for formal events or business settings.",
        category: .mensFormalwear,
        size: .large,
        price: 30.00,
        color: .black,
        condition: "Like New",
        photoURLs: ["https://m.media-amazon.com/images/I/615cmpXtCRL._AC_SY879_.jpg"],
        tags: [.formal, .business, .classy],
        brand: "Hugo Boss",
        maxRentalDuration: .twoWeeks,
        pickupLocation: .tepper,
        available: true,
        rating: 4.9
    ),
    
    Listing(
        id: UUID(),
        title: "Red Sports Jacket",
        creationTime: Date(),
        description: "Bright red jacket for activewear. Great for sports and outdoor activities.",
        category: .mensActivewear,
        size: .small,
        price: 20.00,
        color: .red,
        condition: "Fair",
        photoURLs: ["https://i.etsystatic.com/12576605/r/il/97e9d6/4737590672/il_fullxfull.4737590672_f3d4.jpg"],
        tags: [.sportswear, .casual],
        brand: "Nike",
        maxRentalDuration: .oneWeek,
        pickupLocation: .fifthClyde,
        available: true,
        rating: 4.3
    )
]
