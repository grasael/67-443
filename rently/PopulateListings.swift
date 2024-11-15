//
//  PopulateListings.swift
//  rently
//
//  Created by Tishyaa Chaudhry on 11/5/24.
//

import Foundation
import FirebaseFirestore
import Firebase

// Initialize Firestore
let db = Firestore.firestore()

func populateListings() {
    // Array of sample data for Listings
   
  let sampleListings: [[String: Any]] = [
      [
          "title": "Wool Winter Coat",
          "userID": "1",
          "creationTime": Timestamp(date: Date()),
          "description": "Stay warm with this elegant wool coat.",
          "category": "Women's Outerwear",
          "size": "M",
          "price": 85.0,
          "color": "Gray",
          "condition": "Used - Excellent",
          "photoURLs": ["https://example.com/photo1.jpg"],
          "tags": ["classy", "business"],
          "brand": "CozyWear",
          "maxRentalDuration": "2 weeks",
          "pickupLocations": ["Gates School of Computer Science", "Jared L. Cohon University Center"],
          "available": true,
      ],
      [
          "title": "Black Leather Jacket",
          "userID": "1",
          "creationTime": Timestamp(date: Date()),
          "description": "Edgy black leather jacket, perfect for concerts.",
          "category": "Men's Outerwear",
          "size": "L",
          "price": 60.0,
          "color": "Black",
          "condition": "Used - Good",
          "photoURLs": ["https://example.com/photo2.jpg"],
          "tags": ["edgy", "concert"],
          "brand": "UrbanEdge",
          "maxRentalDuration": "1 week",
          "pickupLocations": ["Tepper School of Business", "Gates School of Computer Science"],
          "available": true,
      ],
      [
          "title": "Formal Tuxedo Suit",
          "userID": "1",
          "creationTime": Timestamp(date: Date()),
          "description": "Elegant tuxedo for formal occasions.",
          "category": "Men's Formalwear",
          "size": "M",
          "price": 120.0,
          "color": "Black",
          "condition": "Used - Like New",
          "photoURLs": ["https://example.com/photo3.jpg"],
          "tags": ["formal", "business"],
          "brand": "ElegantWear",
          "maxRentalDuration": "1 month",
          "pickupLocations": ["Fifth and Clyde", "Mellon Institute"],
          "available": true,
      ],
      [
          "title": "Red Satin Dress",
          "userID": "1",
          "creationTime": Timestamp(date: Date()),
          "description": "Gorgeous satin dress for parties.",
          "category": "Dresses",
          "size": "S",
          "price": 70.0,
          "color": "Red",
          "condition": "New",
          "photoURLs": ["https://example.com/photo4.jpg"],
          "tags": ["party", "classy"],
          "brand": "Glamour",
          "maxRentalDuration": "2 weeks",
          "pickupLocations": ["Jared L. Cohon University Center", "Forbes Beeler Apartments"],
          "available": true,
      ],
      [
          "title": "Vintage Denim Jacket",
          "userID": "1",
          "creationTime": Timestamp(date: Date()),
          "description": "Classic denim jacket with a vintage touch.",
          "category": "Women's Outerwear",
          "size": "M",
          "price": 40.0,
          "color": "Blue",
          "condition": "Used - Fair",
          "photoURLs": ["https://example.com/photo5.jpg"],
          "tags": ["vintage", "casual"],
          "brand": "RetroStyle",
          "maxRentalDuration": "1 week",
          "pickupLocations": ["Gates School of Computer Science", "Tepper School of Business"],
          "available": true,
      ],
      [
          "title": "Sports Hoodie",
          "userID": "1",
          "creationTime": Timestamp(date: Date()),
          "description": "Comfortable hoodie for workouts and casual wear.",
          "category": "Women's Activewear",
          "size": "L",
          "price": 25.0,
          "color": "Gray",
          "condition": "Used - Good",
          "photoURLs": ["https://example.com/photo6.jpg"],
          "tags": ["sportswear", "casual"],
          "brand": "Athletica",
          "maxRentalDuration": "1 month",
          "pickupLocations": ["Mellon Institute", "Jared L. Cohon University Center"],
          "available": true,
      ],
      [
          "title": "Y2K Graphic Tee",
          "userID": "1",
          "creationTime": Timestamp(date: Date()),
          "description": "Trendy Y2K-style graphic tee.",
          "category": "Women's Tops",
          "size": "S",
          "price": 15.0,
          "color": "Pink",
          "condition": "New",
          "photoURLs": ["https://example.com/photo7.jpg"],
          "tags": ["y2k", "casual"],
          "brand": "Nostalgia",
          "maxRentalDuration": "1 week",
          "pickupLocations": ["Gates School of Computer Science", "Fifth and Clyde"],
          "available": true,
      ],
      [
          "title": "Cozy Cardigan Sweater",
          "userID": "1",
          "creationTime": Timestamp(date: Date()),
          "description": "Soft and cozy cardigan for chilly days.",
          "category": "Women's Tops",
          "size": "M",
          "price": 35.0,
          "color": "Cream",
          "condition": "New",
          "photoURLs": ["https://example.com/photo8.jpg"],
          "tags": ["casual", "classy"],
          "brand": "WarmThreads",
          "maxRentalDuration": "2 weeks",
          "pickupLocations": ["Tepper School of Business", "Jared L. Cohon University Center"],
          "available": true,
      ],
      [
          "title": "Classic Black Blazer",
          "userID": "1",
          "creationTime": Timestamp(date: Date()),
          "description": "A stylish blazer perfect for business meetings.",
          "category": "Men's Tops",
          "size": "L",
          "price": 50.0,
          "color": "Black",
          "condition": "Used - Excellent",
          "photoURLs": ["https://example.com/photo9.jpg"],
          "tags": ["business", "formal"],
          "brand": "SharpStyle",
          "maxRentalDuration": "2 weeks",
          "pickupLocations": ["Gates School of Computer Science", "Tepper School of Business"],
          "available": true,
      ],
      [
          "title": "Boho Maxi Dress",
          "userID": "1",
          "creationTime": Timestamp(date: Date()),
          "description": "Flowy maxi dress with a bohemian style.",
          "category": "Dresses",
          "size": "M",
          "price": 45.0,
          "color": "Tan",
          "condition": "New",
          "photoURLs": ["https://example.com/photo10.jpg"],
          "tags": ["vintage", "classy"],
          "brand": "EarthyVibes",
          "maxRentalDuration": "1 month",
          "pickupLocations": ["Forbes Beeler Apartments", "Mellon Institute"],
          "available": true,
      ]
  ]


    // Loop to add each listing to Firestore
    for listing in sampleListings {
      
        var ref: DocumentReference? = nil
        ref = db.collection("Listings").addDocument(data: listing) { err in
            if let err = err {
                print("Error adding document: \(err)")
            } else if let listingID = ref?.documentID {
                print("Listing added with ID: \(listingID)")
          
            }
        }
    }
}
