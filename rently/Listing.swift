//
//  Listing.swift
//  rently
//
//  Created by Abby Chen on 11/2/24.
//

import Foundation

enum ItemSize: String {
  case xxsmall = "XXS"
  case xsmall = "XS"
  case small = "S"
  case medium = "M"
  case large = "L"
  case xlarge = "XL"
  case xxlarge = "XXL"
}

enum ItemColor: String, CaseIterable {
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

enum Category: String, CaseIterable {
  // womenswear categories
  case womensTops = "Women's Tops"
  case womensBottoms = "Women's Bottoms"
  case dresses = "Dresses"
  case womensOuterwear = "Women's Outerwear"
  case womensActivewear = "Women's Activewear"
      
  // menswear categories
  case mensTops = "Men's Tops"
  case mensBottoms = "Men's Bottoms"
  case mensOuterwear = "Men's Outerwear"
  case mensActivewear = "Men's Activewear"
  case mensFormalwear = "Men's Formalwear"
}

enum RentalDuration: String {
  case oneWeek = "1 week"
  case twoWeeks = "2 weeks"
  case oneMonth = "1 month"
  case twoMonths = "2 months"
  case threeMonths = "3 months"
  case fourMonths = "4 months"
}

enum TagOption: String, CaseIterable {
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

enum PickupLocation: String, CaseIterable {
  case uc = "Jared L. Cohon University Center"
  case fifthClyde = "Fifth and Clyde"
  case tepper = "Tepper School of Business"
  case gates = "Gates School of Computer Science"
  case forbesBeeler = "Forbes Beeler Apartments"
  case mellonInstitute = "Mellon Institute"
}

struct Listing: Identifiable {
  var id = UUID()
  var title: String
  var creationTime: Date
  var description: String
  var category: Category
  var size: ItemSize
  var price: Double
  var color: ItemColor
  var condition: String
  var photoURLs: [String]
  var tags: [TagOption]
  var brand: String
  var maxRentalDuration: RentalDuration
  var pickupLocation: PickupLocation
  var available: Bool
  var rating: Float
}
