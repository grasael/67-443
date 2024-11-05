//
//  TrendingItem.swift
//  rently
//
//  Created by Tishyaa Chaudhry on 11/4/24.
//

import Foundation
import FirebaseFirestore

struct TrendingItem: Identifiable, Decodable {
    @DocumentID var id: String?
    var name: String
    var thumbnailUrl: String
    var priority: Int
}
