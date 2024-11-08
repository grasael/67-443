//
//  MockListing.swift
//  rently
//
//  Created by Grace Liao on 11/8/24.
//

import Foundation

struct MockListing: Identifiable {
    var id = UUID()
    var title: String
    var pricePerDay: Double
    var imageUrl: String
    var tags: [String]
}
