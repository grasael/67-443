//
//  User.swift
//  rently
//
//  Created by Grace Liao on 10/31/24.
//

import Foundation

struct User: Codable, Identifiable {
    let id: String
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
    var notifications: [Notification]
    //var busySlots: [BusySlot]
}
