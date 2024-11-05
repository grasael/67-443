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
   
  let sampleListings = [
      [
          "title": "Vintage Leather Jacket",
          "creationTime": Timestamp(date: Date()),
          "description": "A stylish vintage leather jacket in excellent condition.",
          "category": "Clothing",
          "size": "M",
          "price": 75.0,
          "color": "Brown",
          "condition": "Used - Like New",
          "photoURLs": ["https://example.com/photo1.jpg"],
          "tags": ["vintage", "edgy", "casual"],
          "brand": "LeatherCo",
          "maxRentalDuration": 7,
          "pickupLocations": ["Gates", "Posner", "UC"],
          "available": true,
          "rating": 4.5
      ],
      [
          "title": "Designer Evening Gown",
          "creationTime": Timestamp(date: Date()),
          "description": "A luxurious evening gown perfect for formal events.",
          "category": "Clothing",
          "size": "S",
          "price": 120.0,
          "color": "Red",
          "condition": "New",
          "photoURLs": ["https://example.com/photo2.jpg"],
          "tags": ["formal", "classy", "party"],
          "brand": "GlamourWear",
          "maxRentalDuration": 3,
          "pickupLocations": ["Gates", "Posner", "UC"],
          "available": true,
          "rating": 4.9
      ],
      [
          "title": "Casual Denim Jacket",
          "creationTime": Timestamp(date: Date()),
          "description": "A classic denim jacket suitable for all seasons.",
          "category": "Clothing",
          "size": "L",
          "price": 40.0,
          "color": "Blue",
          "condition": "Used - Good",
          "photoURLs": ["https://example.com/photo3.jpg"],
          "tags": ["streetwear", "casual"],
          "brand": "DenimWorks",
          "maxRentalDuration": 10,
          "pickupLocations": ["Gates", "Posner", "UC"],
          "available": true,
          "rating": 4.3
      ],
      [
          "title": "Wool Winter Coat",
          "creationTime": Timestamp(date: Date()),
          "description": "Stay warm with this elegant wool coat.",
          "category": "Clothing",
          "size": "M",
          "price": 85.0,
          "color": "Gray",
          "condition": "Used - Excellent",
          "photoURLs": ["https://example.com/photo4.jpg"],
          "tags": ["classy", "business"],
          "brand": "CozyWear",
          "maxRentalDuration": 14,
          "pickupLocations": ["Gates", "Posner", "UC"],
          "available": true,
          "rating": 4.7
      ],
      [
          "title": "Floral Summer Dress",
          "creationTime": Timestamp(date: Date()),
          "description": "Lightweight and comfortable, perfect for summer days.",
          "category": "Clothing",
          "size": "S",
          "price": 30.0,
          "color": "White",
          "condition": "New",
          "photoURLs": ["https://example.com/photo5.jpg"],
          "tags": ["casual", "party"],
          "brand": "SunshineStyle",
          "maxRentalDuration": 5,
          "pickupLocations": ["Gates", "Posner", "UC"],
          "available": true,
          "rating": 4.6
      ],
      [
          "title": "Athletic Tracksuit",
          "creationTime": Timestamp(date: Date()),
          "description": "Comfortable and stretchy tracksuit for workouts or casual wear.",
          "category": "Clothing",
          "size": "M",
          "price": 55.0,
          "color": "Black",
          "condition": "New",
          "photoURLs": ["https://example.com/photo6.jpg"],
          "tags": ["sportswear", "casual"],
          "brand": "FitWear",
          "maxRentalDuration": 10,
          "pickupLocations": ["Gates", "Posner", "UC"],
          "available": true,
          "rating": 4.8
      ],
      [
          "title": "Business Suit",
          "creationTime": Timestamp(date: Date()),
          "description": "A sleek suit for professional events.",
          "category": "Clothing",
          "size": "L",
          "price": 100.0,
          "color": "Navy",
          "condition": "Used - Excellent",
          "photoURLs": ["https://example.com/photo7.jpg"],
          "tags": ["business", "formal"],
          "brand": "SharpDresser",
          "maxRentalDuration": 7,
          "pickupLocations": ["Gates", "Posner", "UC"],
          "available": true,
          "rating": 4.4
      ],
      [
          "title": "Waterproof Raincoat",
          "creationTime": Timestamp(date: Date()),
          "description": "Stay dry with this lightweight raincoat.",
          "category": "Clothing",
          "size": "M",
          "price": 35.0,
          "color": "Yellow",
          "condition": "New",
          "photoURLs": ["https://example.com/photo8.jpg"],
          "tags": ["casual"],
          "brand": "RainSafe",
          "maxRentalDuration": 5,
          "pickupLocations": ["Gates", "Posner", "UC"],
          "available": true,
          "rating": 4.2
      ],
      [
          "title": "Cozy Hoodie",
          "creationTime": Timestamp(date: Date()),
          "description": "A cozy and soft hoodie for casual wear.",
          "category": "Clothing",
          "size": "XL",
          "price": 25.0,
          "color": "Green",
          "condition": "Used - Good",
          "photoURLs": ["https://example.com/photo9.jpg"],
          "tags": ["casual", "streetwear"],
          "brand": "WarmWear",
          "maxRentalDuration": 10,
          "pickupLocations": ["Gates", "Posner", "UC"],
          "available": true,
          "rating": 4.1
      ],
      [
          "title": "Retro Graphic T-shirt",
          "creationTime": Timestamp(date: Date()),
          "description": "A funky retro t-shirt with a unique graphic design.",
          "category": "Clothing",
          "size": "L",
          "price": 20.0,
          "color": "White",
          "condition": "New",
          "photoURLs": ["https://example.com/photo10.jpg"],
          "tags": ["y2k", "casual"],
          "brand": "ThrowbackStyle",
          "maxRentalDuration": 7,
          "pickupLocations": ["Gates", "Posner", "UC"],
          "available": true,
          "rating": 4.3
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
                
                // Adding a sample review to the reviews subcollection for each listing
                let review = [
                    "time": Timestamp(date: Date()),
                    "rentalID": db.collection("Rentals").document("someRentalID"), // Update with actual RentalID reference
                    "itemID": ref!,  // Reference to the listing itself
                    "text": "Great item, just as described!",
                    "rating": 5,
                    "hasDamages": false,
                    "condition": "Good"
                ] as [String : Any]
                
                db.collection("Listings").document(listingID).collection("reviews").addDocument(data: review) { err in
                    if let err = err {
                        print("Error adding review: \(err)")
                    } else {
                        print("Review added for listing with ID: \(listingID)")
                    }
                }
            }
        }
    }
}
