//
//  Review.swift
//  rently
//
//  Created by Grace Liao on 11/7/24.
//

import Foundation
import FirebaseFirestore

struct Review: Identifiable, Codable {
    @DocumentID var id: String?
    var condition: Bool
    var hasDamages: Bool
    var itemID: String
    var rating: Int
    var rentalID: String
    var text: String
    var time: Date
    var userID: String
    
    // MARK: Codable
    enum CodingKeys: String, CodingKey {
        case id
        case condition
        case hasDamages
        case itemID
        case rating
        case rentalID
        case text
        case time
        case userID
    }
}
