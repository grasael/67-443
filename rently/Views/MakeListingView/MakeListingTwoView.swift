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
    @State private var isSaving = false
    @State private var saveError: String? = nil

    let user: User
    @EnvironmentObject var viewModel: ListingsViewModel
    @Binding var draft: ListingDraft

    var body: some View {
        ScrollView {
            VStack(alignment: .leading, spacing: 16) {
                // title
                Text("make a listing")
                    .font(.title)
                    .bold()
                    .padding(.horizontal, 30)

                // date picker
                Text("select dates when you're unavailable for pickups:")
                    .font(.system(size: 16))
                    .padding(.horizontal, 30)
                Text("you can always edit this in your settings!")
                    .font(.system(size: 14))
                    .padding(.horizontal, 30)

                // calendar
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

                // rental duration picker
                Text("max rental duration:")
                    .font(.system(size: 16))
                    .padding(.horizontal, 30)

                Picker("max rental duration", selection: $maxRentalDuration) {
                  ForEach(RentalDuration.allCases, id: \.self) { duration in
                        Text(duration.rawValue).tag(duration)
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

                // upload button
                Button(action: {
                    saveListingAndRedirect()
                }) {
                    Text(isSaving ? "saving..." : "upload")
                        .font(.system(size: 22))
                        .foregroundColor(.white)
                        .padding(.vertical, 8)
                        .padding(.horizontal, 40)
                        .background(
                            LinearGradient(
                                gradient: Gradient(colors: [Color("MediumBlue"), Color("LightGreen")]),
                                startPoint: .leading,
                                endPoint: .trailing
                            )
                        )
                        .cornerRadius(25)
                        .shadow(radius: 5)
                }
                .disabled(isSaving)
                .frame(maxWidth: 200)
                .frame(maxWidth: .infinity)
                .padding(.top)

                if let errorMessage = saveError {
                    Text(errorMessage)
                        .foregroundColor(.red)
                        .padding(.top)
                }
            }
            .padding()
        }
        .navigationDestination(isPresented: $nextScreen) {
          ProfileView(user: user) // redirect to ProfileView
        }
        .alert(isPresented: .constant(saveError != nil)) {
            Alert(
                title: Text("Error"),
                message: Text(saveError ?? "Unknown error occurred"),
                dismissButton: .default(Text("OK"), action: { saveError = nil })
            )
        }
    }

  private func saveListingAndRedirect() {
    isSaving = true
    saveError = nil

    // update draft
    draft.maxRentalDuration = maxRentalDuration
    draft.pickupLocations = selectedLocations
    
    guard let userId = user.id else {
        saveError = "User ID is missing. Cannot save listing."
        isSaving = false
        return
    }

    viewModel.addListingFromDraft(draft, userID: userId) { result in
      isSaving = false
      switch result {
        case .success:
          nextScreen = true
        case .failure(let error):
          saveError = error.localizedDescription
      }
    }
  }
}
