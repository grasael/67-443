//
//  Listing.swift
//  rently
//
//  Created by Abby Chen on 11/2/24.
//

import Foundation
import PhotosUI

enum ItemSize: String, CaseIterable {
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

enum RentalDuration: String, CaseIterable {
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
  case uc = "jared l. cohon university center"
  case fifthClyde = "fifth and clyde"
  case tepper = "tepper school of business"
  case gates = "gates school of computer science"
  case forbesBeeler = "forbes beeler apartments"
  case mellonInstitute = "mellon institute"
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
  var images: [UIImage]
  var brand: String
  var maxRentalDuration: RentalDuration
  var pickupLocation: PickupLocation
  var available: Bool
  var rating: Float
}
