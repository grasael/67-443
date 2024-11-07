//
//  Listing.swift
//  rently
//
//  Created by Abby Chen on 11/2/24.
//

import Foundation

import Foundation
import FirebaseFirestore

// Enums
enum ItemSize: String, Codable {
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
    case womensTops = "Women's Tops"
    case womensBottoms = "Women's Bottoms"
    case dresses = "Dresses"
    case womensOuterwear = "Women's Outerwear"
    case womensActivewear = "Women's Activewear"
    case mensTops = "Men's Tops"
    case mensBottoms = "Men's Bottoms"
    case mensOuterwear = "Men's Outerwear"
    case mensActivewear = "Men's Activewear"
    case mensFormalwear = "Men's Formalwear"
}

enum Condition: String, CaseIterable, Codable {
    case brandNew = "brand new"
    case veryGood = "very good"
    case good = "good"
    case fair = "fair"
}

enum RentalDuration: String, Codable {
    case oneWeek = "1 week"
    case twoWeeks = "2 weeks"
    case oneMonth = "1 month"
    case twoMonths = "2 months"
    case threeMonths = "3 months"
    case fourMonths = "4 months"
}

enum TagOption: String, CaseIterable, Codable{
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

enum PickupLocation: String, CaseIterable, Codable{
    case uc = "Jared L. Cohon University Center"
    case fifthClyde = "Fifth and Clyde"
    case tepper = "Tepper School of Business"
    case gates = "Gates School of Computer Science"
    case forbesBeeler = "Forbes Beeler Apartments"
    case mellonInstitute = "Mellon Institute"
}

// Listing Model
struct Listing: Identifiable, Codable {
  @DocumentID var id: String?
  var title: String
  var creationTime: Date
  var description: String
  var category: Category
  var userID: String
  var size: ItemSize
  var price: Double
  var color: ItemColor
  var condition: Condition
  var photoURLs: [String]
  var tags: [TagOption]
  var brand: String
  var maxRentalDuration: RentalDuration
  var pickupLocations: [PickupLocation]
  var available: Bool
  //adding a reviews variable here for the subcollection doesnt work so we will need to read it separately
}
  // Review Model (Subcollection)
  struct Review: Identifiable, Codable {
    @DocumentID var id: String?
    var time: Date
    var rentalID: String
    var text: String
    var rating: Int
    var hasDamages: Bool
    var condition: String
}
