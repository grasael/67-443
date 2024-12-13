//
//  RentalDetailView.swift
//  rently
//
//  Created by Tishyaa Chaudhry on 11/4/24.
//
import Foundation
import SwiftUI

struct RentalDetailView: View {
    @Environment(\.presentationMode) var presentationMode
    var rental: Rental // Add a rental property
    
    var body: some View {
        ZStack {
            // Add a blue and green gradient background
            LinearGradient(gradient: Gradient(colors: [Color("LightestBlue"),Color("LightGreen"), Color("Yellow")]), startPoint: .top, endPoint: .bottom)
                .edgesIgnoringSafeArea(.all)
                .opacity(0.2)
             
                
            
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
}

struct RentalDetailView_Previews: PreviewProvider {
    static var previews: some View {
        // Create a sample Rental instance with dummy data
        let rental = Rental(
            id: "1",
            renteeID: "rentee123",
            renterID: "renter456",
            startDate: Calendar.current.date(byAdding: .day, value: 5, to: Date())!,
            endDate: Calendar.current.date(byAdding: .day, value: 10, to: Date())!,
            pickupLocation: "123 Main St",
            listingID: "listing789",
            message: "Looking forward to the rental!",
            status: "active"
        )
        
        return RentalDetailView(rental: rental)
            .previewLayout(.sizeThatFits) // Adjust preview size
            .padding()
    }
}
