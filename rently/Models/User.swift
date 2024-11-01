//
//  User.swift
//  rently
//
//  Created by Grace Liao on 10/31/24.
//

import Foundation
import FirebaseFirestore

struct User: Codable, Identifiable {
    @DocumentID var id: String? = UUID().uuidString
    var firstName: String
    var lastName: String
    var username: String
    var pronouns: String
    var email: String
    var password: String
    var university: String
    var rating: Float
    var listings: [String] // Listing IDs
    var likedItems: [String] // Item IDs
    var styleChoices: [String]
    var events: [String]
    //var notifications: [Notification]
    //var busySlots: [BusySlot]
    
    // MARK: Codable
    enum CodingKeys: String, CodingKey {
        case id
        case firstName = "FirstName"
        case lastName = "LastName"
        case username
        case pronouns = "Pronouns"
        case email = "Email"
        case password = "Password"
        case university = "University"
        case rating = "Rating"
        case listings = "ItemListings"
        case likedItems = "LikedItems"
        case styleChoices = "StyleChoices"
        case events = "Events"
    }
}
