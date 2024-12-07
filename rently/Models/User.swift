//
//  User.swift
//  rently
//
//  Created by Grace Liao on 10/31/24.
//

import Foundation
import FirebaseFirestore

struct User: Codable, Identifiable {
    @DocumentID var id: String? //= UUID().uuidString
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
    var followers: [String]
    var following: [String]
    
    // MARK: Codable
    enum CodingKeys: String, CodingKey {
        case id
        case firstName
        case lastName
        case username
        case pronouns
        case email
        case password
        case university
        case rating
        case listings
        case likedItems
        case styleChoices
        case events
        case followers
        case following
    }
}
