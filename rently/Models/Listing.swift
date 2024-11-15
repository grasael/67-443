//
//  Listing.swift
//  rently
//
//  Created by Abby Chen on 11/2/24.
//

import Foundation
import PhotosUI

enum ItemSize: String, CaseIterable, Codable {
  case xxsmall = "XXS"
  case xsmall = "XS"
  case small = "S"
  case medium = "M"
  case large = "L"
  case xlarge = "XL"
  case xxlarge = "XXL"
}

enum ItemColor: String, CaseIterable, Codable {
  case red = "red"
  case orange = "orange"
  case yellow = "yellow"
  case green = "green"
  case blue = "blue"
  case purple = "purple"
  case pink = "pink"
  case black = "black"
  case white = "white"
  case brown = "brown"
  case cream = "cream"
  case tan = "tan"
}

enum Category: String, CaseIterable, Codable {
  // womenswear categories
  case womensTops = "women's tops"
  case womensBottoms = "women's bottoms"
  case dresses = "dresses"
  case womensOuterwear = "women's outerwear"
  case womensActivewear = "women's activewear"
      
  // menswear categories
  case mensTops = "men's tops"
  case mensBottoms = "men's bottoms"
  case mensOuterwear = "men's outerwear"
  case mensActivewear = "men's activewear"
  case mensFormalwear = "men's formalwear"
}

enum RentalDuration: String, CaseIterable, Codable {
  case oneWeek = "1 week"
  case twoWeeks = "2 weeks"
  case oneMonth = "1 month"
  case twoMonths = "2 months"
  case threeMonths = "3 months"
  case fourMonths = "4 months"
}

enum TagOption: String, CaseIterable, Codable {
  case vintage = "vintage"
  case formal = "formal"
  case sportswear = "sportswear"
  case edgy = "edgy"
  case business = "business"
  case party = "party"
  case costume = "costume"
  case concert = "concert"
  case classy = "classy"
  case casual = "casual"
  case streetwear = "streetwear"
  case y2k = "y2k"
  case graduation = "graduation"
}

enum PickupLocation: String, CaseIterable, Codable {
  case uc = "jared l. cohon university center"
  case fifthClyde = "fifth and clyde"
  case tepper = "tepper school of business"
  case gates = "gates school of computer science"
  case forbesBeeler = "forbes beeler apartments"
  case mellonInstitute = "mellon institute"
}

struct Listing: Identifiable, Codable {
    var id: String
    var title: String
    var creationTime: Date
    var description: String
    var category: String
    var size: String
    var price: Double
    var color: String
    var condition: String
    var photoURLs: [String]
    var tags: [String]
    var brand: String
    var maxRentalDuration: String
    var pickupLocation: String
    var available: Bool
    var rating: Float
}
