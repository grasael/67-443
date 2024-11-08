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
  @State private var selectedDates: Set<Date> = []
  @State private var displayedMonth: Date = Date()
  @State private var maxRentalDuration: RentalDuration = .oneWeek
  @State private var selectedLocations: [PickupLocation] = []
  @State private var nextScreen = false
  
  let user: User

  
  var body: some View {
    ScrollView {
      VStack(alignment: .leading, spacing: 16) {
        // page title
        Text("make a listing")
          .font(/*@START_MENU_TOKEN@*/.title/*@END_MENU_TOKEN@*/)
          .bold()
          .padding(.horizontal, 30)
        
        // date picker
        Text("select dates when you're out of town or unavailable for pickups:")
          .font(.system(size: 16))
          .padding(.horizontal, 30)
        Text("you can always edit this in your settings!")
          .font(.system(size: 14))
          .padding(.horizontal, 30)
        
        // add the calendar
        CalendarWrapperView(selectedDates: $selectedDates)
          .frame(height: 400)
          .padding(.horizontal)

        // display selected (unavailable) dates below the calendar
        if !selectedDates.isEmpty {
          VStack(alignment: .leading, spacing: 5) {
            ForEach(Array(selectedDates).sorted(), id: \.self) { date in
              Text(date.formatted(date: .abbreviated, time: .omitted))
                .foregroundColor(.red)
            }
            .padding(.horizontal, 10)
          }
          .padding(.horizontal)
        }
        
        // max rental duration picker
        Text("max rental duration:")
          .font(.system(size: 16))
          .padding(.horizontal, 30)
        
        Picker("max rental duration", selection: $maxRentalDuration) {
          ForEach(RentalDuration.allCases, id: \.self) {
            duration in Text(duration.rawValue).tag(duration)
          }
        }
        .pickerStyle(MenuPickerStyle())
        .padding()
        .background(Color.white)
        .cornerRadius(8)
        .overlay(
          RoundedRectangle(cornerRadius: 8)
            .stroke(Color.black, lineWidth: 1)
        )
        .padding(.horizontal, 30)
        .padding(.bottom, 30)
        
        // pickup locations
        Text("select pickup locations:")
          .font(.system(size: 16))
          .padding(.horizontal, 30)
        
        ForEach(PickupLocation.allCases, id: \.self) { location in
          CheckboxView(
            isChecked: Binding(
              get: { selectedLocations.contains(location) },
              set: { isSelected in
                if isSelected {
                  selectedLocations.append(location)
                } else {
                  selectedLocations.removeAll { $0 == location }
                }
              }
            ),
            label: location.rawValue
          )
          .padding(.horizontal, 30)
        }
        
        Spacer()
        
        Rectangle()
          .fill(Color.gray.opacity(0.4))
          .frame(height: 1)
        
        // upload listing
        NavigationLink(
          destination: ProfileView(user: user),
          isActive: $nextScreen
        ) {
          Text("upload")
            .font(.system(size: 22))
            .foregroundColor(.white)
            .padding(.vertical, 8)
            .padding(.horizontal, 40)
            .background(
              LinearGradient(
                gradient: Gradient(colors: [Color("MediumBlue"), Color("PaleGreen")]),
                startPoint: .leading,
                endPoint: .trailing
              )
            )
            .cornerRadius(25)
            .shadow(radius: 5)
        }
        .frame(maxWidth: 200)
        .frame(maxWidth: .infinity)
        .padding(.top)
      }
      .padding()
    }
    Spacer()
  }
}

#Preview {
  MakeListingTwoView(user: User(
    id: "123",
            firstName: "Abby",
            lastName: "Chen",
            username: "abbychen",
            pronouns: "she/her",
            email: "abby@example.com",
            password: "password123",
            university: "CMU",
            rating: 4.8,
            listings: ["list1", "list2"], // Example Listing IDs
            likedItems: ["item1", "item2"], // Example Liked Item IDs
            styleChoices: ["vintage", "formal"],
            events: ["event1", "event2"]
        ))
}
