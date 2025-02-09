//
//  RentAnItemView.swift
//  rently
//
//  Created by Tishyaa Chaudhry on 12/4/24.
//

import Foundation
import SwiftUI

struct RentAnItemView: View {
    var listing: Listing
    @State private var pickupDate = Date()
    @State private var pickupTime = Date()
    @State private var dropoffDate = Date()
    @State private var dropoffTime = Date()
    @State private var location: String = ""
 

    private var maxDropoffDate: Date {
        var calendar = Calendar.current
        switch listing.maxRentalDuration {
        case .oneWeek:
            return calendar.date(byAdding: .weekOfYear, value: 1, to: pickupDate) ?? pickupDate
        case .twoWeeks:
            return calendar.date(byAdding: .weekOfYear, value: 2, to: pickupDate) ?? pickupDate
        case .oneMonth:
            return calendar.date(byAdding: .month, value: 1, to: pickupDate) ?? pickupDate
        case .twoMonths:
            return calendar.date(byAdding: .month, value: 2, to: pickupDate) ?? pickupDate
        case .threeMonths:
            return calendar.date(byAdding: .month, value: 3, to: pickupDate) ?? pickupDate
        case .fourMonths:
            return calendar.date(byAdding: .month, value: 4, to: pickupDate) ?? pickupDate
        }
    }

    var body: some View {
        ScrollView {
            VStack(alignment: .leading, spacing: 16) {
                Text("Rent Item")
                    .font(.largeTitle)
                    .fontWeight(.bold)

                // Pickup Date Picker
                Text("Select Pickup Date:")
                DatePicker("",
                           selection: $pickupDate,
                           displayedComponents: .date)
                    .datePickerStyle(GraphicalDatePickerStyle())
                    .onChange(of: pickupDate) { newPickupDate in
                        dropoffDate = max(newPickupDate, dropoffDate)
                        if dropoffDate > maxDropoffDate {
                            dropoffDate = maxDropoffDate
                        }
                    }

                // Dropoff Date Picker
                Text("Select Dropoff Date:")
                Text("Max rental duration: \(formattedMaxRentalDuration())")
                    .font(.footnote)
                    .foregroundColor(.gray)
                    .padding(.top, 1)
                DatePicker("Select Dropoff Date",
                           selection: Binding(
                               get: { dropoffDate },
                               set: { newDropoffDate in
                                   dropoffDate = max(pickupDate, newDropoffDate)
                                   if dropoffDate > maxDropoffDate {
                                       dropoffDate = maxDropoffDate
                                   }
                               }
                           ),
                           in: pickupDate...,
                           displayedComponents: .date)
                    .datePickerStyle(GraphicalDatePickerStyle())

                // Location Picker
                Text("Select Pickup and Dropoff Location:")
                    .foregroundColor(.black) // Ensure the label is black

                Picker("Location", selection: $location) {
                    ForEach(listing.pickupLocations, id: \.self) { location in
                        Text(location.rawValue)
                            .tag(location.rawValue)
                            .foregroundColor(.black) // Ensure picker options are black
                    }
                }
                .pickerStyle(MenuPickerStyle()) // Set the picker style
                .accentColor(Color("MediumGreen")) // Set the accent color for the Picker options
                .padding()
                .background(Color.white)
                .cornerRadius(8)
                .overlay(
                    RoundedRectangle(cornerRadius: 8)
                        .stroke(Color.black, lineWidth: 1)
                )
                .padding(.horizontal, 30)
                .padding(.bottom, 30)


                Spacer()

                // Navigation Link to Confirmation View
                NavigationLink(
                    destination: ConfirmationView(
                        listing: listing,
                        pickupDate: pickupDate,
                        dropoffDate: dropoffDate,
                        location: location
                    )
                ) {
                    Text("Next")
                        .frame(maxWidth: .infinity)
                        .foregroundColor(.white)
                        .padding(.vertical, 10)
                        .padding(.horizontal, 40)
                        .font(.system(size: 16, weight: .semibold))
                        .background(
                            LinearGradient(
                                gradient: Gradient(colors: [Color("MediumBlue"), Color("MediumGreen")]),
                                startPoint: .leading,
                                endPoint: .trailing
                            )
                        )
                        .cornerRadius(20)
                }
                .disabled(!isValidSelection)
            }
            .padding()
        }
        .navigationBarTitle("Rent Item", displayMode: .inline)
        .onAppear {
            location = listing.pickupLocations.first?.rawValue ?? ""
            dropoffDate = max(pickupDate, dropoffDate)
            if dropoffDate > maxDropoffDate {
                dropoffDate = maxDropoffDate
            }
        }
    }

    private var isValidSelection: Bool {
        pickupDate <= dropoffDate && dropoffDate <= maxDropoffDate
    }

    private func formattedMaxRentalDuration() -> String {
        switch listing.maxRentalDuration {
        case .oneWeek: return "1 week"
        case .twoWeeks: return "2 weeks"
        case .oneMonth: return "1 month"
        case .twoMonths: return "2 months"
        case .threeMonths: return "3 months"
        case .fourMonths: return "4 months"
        }
    }
}

// Preview
struct RentAnItemView_Previews: PreviewProvider {
    static var previews: some View {
        let sampleListing = Listing(
            id: "1",
            title: "Princess Polly Romper",
            creationTime: Date(),
            description: "Gorgeous Princess Polly romper, perfect for a picnic or a casual day out. Worn a few times and rented twice, still in very good condition. Please cold wash and air dry.",
            category: .dresses,
            userID: "user",
            size: .small,
            price: 5.0,
            color: .black,
            condition: .veryGood,
            photoURLs: ["https://example.com/sample-image.jpg", "https://example.com/sample-image2.jpg"],
            tags: [.casual, .vintage],
            brand: "Princess Polly",
            maxRentalDuration: .oneWeek,
            pickupLocations: [.uc, .fifthClyde],
            available: true
        )
        NavigationView {
            RentAnItemView(listing: sampleListing)
        }
    }
}
