//
//  RentalContactView.swift
//  rently
//
//  Created by Tishyaa Chaudhry on 11/4/24.
//

import Foundation
import SwiftUI

struct RentalContactView: View {
    @StateObject var viewModel: ActiveRentalsViewModel
    let rental: Rental

    init(rental: Rental, viewModel: ActiveRentalsViewModel = ActiveRentalsViewModel()) {
        self.rental = rental
        _viewModel = StateObject(wrappedValue: viewModel)
    }
    var body: some View {
        VStack {
            HStack {
                Image(systemName: "person.circle")
                    .resizable()
                    .frame(width: 40, height: 40)
                VStack(alignment: .leading) {
                    Text("Rented on \(formattedDate(rental.startDate)) from")
                        .font(.caption)
                        .foregroundColor(.gray)
                    Text("@\(viewModel.renter?.username ?? "Unknown")")
                    Text("\(viewModel.renter?.firstName ?? "Unknown")")
                        .font(.caption)
                        .foregroundColor(.gray)
                }
            }.onAppear {
              print("Rental renter ID: \(rental.renterID)")
              viewModel.loadRenterDetails(rental: rental)
          }
            .padding(.vertical, 8)
            
            Divider()
            
            VStack(alignment: .leading) {
                Text("How can we help?")
                    .font(.headline)
                NavigationLink(destination: ContactUsView()) {
                    HStack {
                        Text("Contact Us")
                        Spacer()
                        Image(systemName: "chevron.right")
                            .foregroundColor(.gray)
                    }
                }
            }
            .padding(.top, 8)
            .padding(.horizontal)
        }
    }
    
    private func formattedDate(_ date: Date) -> String {
        let formatter = DateFormatter()
        formatter.dateStyle = .short
        return formatter.string(from: date)
    }
}

struct ContactUsView: View {
    var body: some View {
        Text("Contact Us Page")
    }
}
