//
//  RentalDetailView.swift
//  rently
//
//  Created by Tishyaa Chaudhry on 11/4/24.
//
import Foundation
import SwiftUI

import SwiftUI

struct RentalDetailView: View {
    @Environment(\.presentationMode) var presentationMode
    var rental: Rental // Add a rental property
    
    var body: some View {
        VStack(alignment: .leading, spacing: 16) {
          RentalHeaderView(presentationMode: _presentationMode)
            RentalItemDetailsView(rental: rental)
            Divider()
            RentalTimelineView(rental: rental)
            Divider()
            RentalPriceView(rental: rental)
            Divider()
            RentalContactView(rental: rental)
            Spacer()
        }
        .navigationBarHidden(true)
    }
}


