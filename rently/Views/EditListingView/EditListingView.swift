//
//  EditListingView.swift
//  rently
//
//  Created by Abby Chen on 12/5/24.
//

import SwiftUI
import PhotosUI

struct EditListingView: View {
  @EnvironmentObject var listingsViewModel: ListingsViewModel
  @EnvironmentObject var userViewModel: UserViewModel
  @Environment(\.dismiss) var dismiss

  @State private var draft: ListingDraft
  @State private var selectedImages: [PhotosPickerItem?] = Array(repeating: nil, count: 4)
  @State private var uploadedImages: [UIImage?] = Array(repeating: nil, count: 4)
  
  @State private var selectedDates: Set<Date> = []
  @State private var selectedLocations: [PickupLocation] = []
  @State private var isSaving = false
  @State private var saveError: String? = nil
  
  let listingID: String
  
  // initialize current listing in listingdraft
  init(listing: Listing) {
    self.listingID = listing.id ?? UUID().uuidString
    _draft = State(initialValue: ListingDraft(
          title: listing.title,
          description: listing.description,
          category: listing.category,
          brand: listing.brand,
          condition: listing.condition,
          photoURLs: listing.photoURLs,
          size: listing.size,
          price: listing.price,
          color: listing.color,
          tags: listing.tags,
          maxRentalDuration: listing.maxRentalDuration,
          pickupLocations: listing.pickupLocations,
          available: listing.available,
          creationTime: listing.creationTime
      ))
  }

  var body: some View {
    NavigationStack {
      ScrollView {
        VStack(alignment: .leading, spacing: 16) {
          // page title
          Text("edit listing")
              .font(.title)
              .bold()
              .padding(.horizontal)
          
          // edit photos upload section
          Text("upload photos (max 4):")
              .font(.system(size: 16))
              .padding(.horizontal)
          
          LazyVGrid(columns: Array(repeating: GridItem(.flexible(), spacing: 10), count: 4), spacing: 10) {
              ForEach(0..<4, id: \.self) { index in
                  if index < draft.photoURLs.count,
                     let url = URL(string: draft.photoURLs[index]),
                     let data = try? Data(contentsOf: url),
                     let image = UIImage(data: data) {
                      // Display existing photo from photoURLs
                      Image(uiImage: image)
                          .resizable()
                          .scaledToFill()
                          .frame(width: 80, height: 80)
                          .clipShape(RoundedRectangle(cornerRadius: 10))
                          .overlay(
                              RoundedRectangle(cornerRadius: 10)
                                  .stroke(Color.black, lineWidth: 1)
                          )
                  } else {
                      // Placeholder for new photos or unassigned slots
                      PhotosPicker(selection: Binding(
                          get: { selectedImages[index] },
                          set: { selectedImages[index] = $0 }
                      ), matching: .images) {
                          ZStack {
                              RoundedRectangle(cornerRadius: 10)
                                  .stroke(Color.black, lineWidth: 1)
                                  .frame(width: 80, height: 80)
                              Image(systemName: "plus")
                                  .foregroundColor(.gray)
                          }
                      }
                      .onChange(of: selectedImages[index]) { newItem in
                          loadSelectedPhoto(for: index, from: newItem)
                      }
                  }
              }
          }
          .padding(.horizontal)
          
          // edit title
          TextField("title", text: $draft.title)
              .padding()
              .background(Color.white)
              .cornerRadius(8)
              .overlay(
                  RoundedRectangle(cornerRadius: 8)
                      .stroke(Color.black, lineWidth: 1)
              )
              .padding(.horizontal)
          
          // edit description
          ZStack(alignment: .topLeading) {
              Color.white
                  .cornerRadius(8)
              
              TextEditor(text: $draft.description)
                  .frame(height: 100)
                  .padding(4)
                  .background(Color.clear)
                  .cornerRadius(8)
                  .overlay(
                      RoundedRectangle(cornerRadius: 8)
                          .stroke(Color.black, lineWidth: 1)
                  )
          }
          .padding(.horizontal)
          
          // edit category and color
          HStack {
              // category picker
              Picker("category", selection: $draft.category) {
                  ForEach(Category.allCases, id: \.self) { category in
                      Text(category.rawValue).tag(category)
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
              
              // color picker
              Picker("color", selection: $draft.color) {
                  ForEach(ItemColor.allCases, id: \.self) { color in
                      Text(color.rawValue).tag(color)
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
          }
          .padding(.horizontal)
          
          // brand
          TextField("brand", text: $draft.brand)
              .padding()
              .background(Color.white)
              .cornerRadius(8)
              .overlay(
                  RoundedRectangle(cornerRadius: 8)
                      .stroke(Color.black, lineWidth: 1)
              )
              .padding(.horizontal)
          
          // condition
          Text("condition: ")
              .font(.system(size: 16))
              .padding(.horizontal)
          HStack {
              ForEach(Condition.allCases, id: \.self) { conditionOption in
                  Button(action: {
                      draft.condition = conditionOption
                  }) {
                      Text(conditionOption.rawValue)
                          .padding(9)
                          .background(draft.condition == conditionOption ? Color.gray.opacity(0.9) : Color.gray.opacity(0.4))
                          .cornerRadius(20)
                          .foregroundColor(.white)
                  }
              }
          }
          .padding(.horizontal)

          // size and price
          HStack {
              // size picker
              Picker("size", selection: $draft.size) {
                  ForEach(ItemSize.allCases, id: \.self) { size in
                      Text(size.rawValue).tag(size)
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
              .padding(.horizontal)
              
              // price
              TextField("price", text: Binding(
                  get: { String(draft.price) },
                  set: { draft.price = Double($0) ?? 0 }
              ))
              .padding()
              .padding(.horizontal, 30)
              .background(Color.white)
              .cornerRadius(8)
              .overlay(
                  RoundedRectangle(cornerRadius: 8)
                      .stroke(Color.black, lineWidth: 1)
              )
              Text("/ day")
              .padding(.horizontal)
          }
          
          // tags
          Text("tags (max 3):")
              .font(.system(size: 16))
              .padding(.horizontal)
          LazyVGrid(columns: [GridItem(.adaptive(minimum: 100), spacing: 10)], spacing: 10) {
              ForEach(TagOption.allCases, id: \.self) { tag in
                  Button(action: {
                      if draft.tags.contains(tag) {
                          draft.tags.removeAll { $0 == tag }
                      } else if draft.tags.count < 3 {
                          draft.tags.append(tag)
                      }
                  }) {
                      Text(tag.rawValue)
                          .padding(.vertical, 8)
                          .padding(.horizontal, 12)
                          .frame(minWidth: 100)
                          .lineLimit(1)
                          .background(draft.tags.contains(tag) ? Color("MediumGreen") : Color("LightGreen"))
                          .foregroundColor(.white)
                          .cornerRadius(20)
                  }
                  .disabled(draft.tags.count >= 3 && !draft.tags.contains(tag))
              }
          }
          .padding(.bottom, 40)
          .padding(.horizontal, 20)
          
          // calendar picker
          Text("select dates when you're unavailable for pickups:")
            .font(.system(size: 16))
            .padding(.horizontal, 30)
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
          
          // Rental Duration Picker
          Text("max rental duration:")
              .font(.system(size: 16))
              .padding(.horizontal, 30)

          Picker("max rental duration", selection: $draft.maxRentalDuration) {
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
          
          // Pickup locations
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
         }
         .padding(.horizontal, 30)
          
          Spacer()
          
          Rectangle()
            .fill(Color.gray.opacity(0.4))
            .frame(height: 1)
          
          // Save button
          Button(action: {
              saveEditedListing()
          }) {
              Text(isSaving ? "Saving..." : "save")
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
          }
          .padding()
      }
      .alert(isPresented: .constant(saveError != nil)) {
          Alert(
              title: Text("Error"),
              message: Text(saveError ?? "Unknown error occurred"),
              dismissButton: .default(Text("OK"), action: { saveError = nil })
          )
      }
      .padding()
    }
    .onAppear {
      loadUploadedImages()
      selectedLocations = draft.pickupLocations
        }
      }
  
  private func loadSelectedPhoto(for index: Int, from item: PhotosPickerItem?) {
    Task {
      if let data = try? await item?.loadTransferable(type: Data.self),
         let image = UIImage(data: data) {
        uploadedImages[index] = image
      }
    }
  }
  
  private func loadUploadedImages() {
      uploadedImages = Array(repeating: nil, count: 4) // Ensure array has 4 slots
      DispatchQueue.global(qos: .userInitiated).async {
          var loadedImages: [UIImage?] = Array(repeating: nil, count: 4)
          for (index, urlString) in draft.photoURLs.enumerated() {
              guard index < 4 else { break } // Prevent out-of-bounds errors
              if let url = URL(string: urlString),
                 let data = try? Data(contentsOf: url),
                 let image = UIImage(data: data) {
                  loadedImages[index] = image
              }
          }
          DispatchQueue.main.async {
              self.uploadedImages = loadedImages
              print("Loaded Images: \(self.uploadedImages)")
          }
      }
  }
  
  private func saveEditedListing() {
      isSaving = true
      saveError = nil
    
      draft.pickupLocations = selectedLocations

      guard let userId = userViewModel.user.id else {
          saveError = "User ID is missing. Cannot save listing."
          isSaving = false
          return
      }

      // Upload new images if any
      let nonNilImages = uploadedImages.compactMap { $0 }
      listingsViewModel.uploadImages(nonNilImages) { urls in
          // Update photo URLs if new ones were uploaded
          if !urls.isEmpty {
              draft.photoURLs = urls
          }

          // Save changes to the listing
        listingsViewModel.editListing(listingID, draft: draft, userID: userViewModel.user.id ?? "") { result in
              DispatchQueue.main.async {
                  isSaving = false
                  switch result {
                  case .success:
                      dismiss()
                  case .failure(let error):
                      saveError = error.localizedDescription
                  }
              }
          }
      }
  }
}

struct EditListingView_Previews: PreviewProvider {
    static var previews: some View {
        // Mock Listing
        let mockListing = Listing(
            id: "0",
            title: "Sample Listing",
            creationTime: Date(),
            description: "A stylish jacket, perfect for cold weather.",
            category: .womensTops,
            userID: "123",
            size: .medium,
            price: 49.99,
            color: .blue,
            condition: .fair,
            photoURLs: [
                "https://firebasestorage.googleapis.com:443/v0/b/rently-439319.firebasestorage.app/o/images%2FAE1C82AA-FA91-4CB0-9EB0-34D3E92EC347.jpg?alt=media&token=4f99483d-4b97-4766-af38-30c8ed00a6e8"
            ],
            tags: [.formal, .casual],
            brand: "Gucci",
            maxRentalDuration: .oneWeek,
            pickupLocations: [.uc, .gates],
            available: true
        )
        
        // Mock ListingsViewModel
        let mockListingsViewModel = ListingsViewModel()
        
        // Mock UserViewModel
        let mockUser = User(
            id: "123",
            firstName: "John",
            lastName: "Doe",
            username: "johndoe",
            pronouns: "he/him",
            email: "johndoe@example.com",
            password: "password123",
            university: "Example University",
            rating: 4.5,
            listings: ["1"],
            likedItems: [],
            styleChoices: ["Casual", "Formal"],
            events: [],
            followers: [],
            following: [],
            renting: [],
            myItems: []
        )
        let mockUserViewModel = UserViewModel(user: mockUser)
        
        return EditListingView(listing: mockListing)
            .environmentObject(mockListingsViewModel)
            .environmentObject(mockUserViewModel)
            .previewLayout(.device)
    }
}
