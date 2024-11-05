//
//  MakeListingTwoView.swift
//  rently
//
//  Created by Abby Chen on 11/3/24.
//

import SwiftUI

// second page of making a listing
struct MakeListingTwoView: View {
  // state variables
  @State private var unavailableDates: [Date] = []
  @State private var maxRentalDuration: RentalDuration = .oneWeek
  @State private var selectedLocations: [PickupLocation] = []

  
  var body: some View {
    VStack(alignment: .leading, spacing: 16) {
      // page title
      Text("make a listing")
        .font(/*@START_MENU_TOKEN@*/.title/*@END_MENU_TOKEN@*/)
        .bold()
    }
  }
}

#Preview {
    MakeListingTwoView()
}
