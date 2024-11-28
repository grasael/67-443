//
//  MakeListingView.swift
//  rently
//
//  Created by Abby Chen on 11/2/24.
//

import SwiftUI
import PhotosUI

struct ListingDraft: Codable {
  var title: String = ""
  var description: String = ""
  var category: Category = .womensTops
  var brand: String = ""
  var condition: Condition = .brandNew
  var photoURLs: [String] = []
  var size: ItemSize = .xxsmall
  var price: Double = 0.0
  var color: ItemColor = .red
  var tags: [TagOption] = []
  var maxRentalDuration: RentalDuration = .oneWeek
  var pickupLocations: [PickupLocation] = []
  var available: Bool = true
  var creationTime: Date = Date()
}

struct MakeListingView: View {
  let user: User
  @Environment(\.presentationMode) var presentationMode
  @EnvironmentObject var viewModel: ListingsViewModel

  @State private var draft = ListingDraft()
  
  // photo selection
  @State private var selectedImages: [PhotosPickerItem?] = Array(repeating: nil, count: 4)
  @State private var uploadedImages: [UIImage?] = Array(repeating: nil, count: 4)
  
  var body: some View {
      NavigationView {
          ScrollView {
              VStack(alignment: .leading, spacing: 16) {
                  // Cancel button
                  HStack {
                      Button(action: {
                          presentationMode.wrappedValue.dismiss()
                      }) {
                          Image(systemName: "xmark")
                              .font(.title2)
                              .padding(10)
                      }
                      Spacer()
                  }
                  
                  // Page title
                  Text("make a listing")
                      .font(.title)
                      .bold()
                  
                  // upload photos
                  Text("upload photos (max 4):")
                      .font(.system(size: 16))
                  
                  LazyVGrid(columns: Array(repeating: GridItem(.flexible(), spacing: 10), count: 4), spacing: 10) {
                      ForEach(0..<4, id: \.self) { index in
                          if let image = uploadedImages[index] {
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
                  
                  // add title
                  TextField("title", text: $draft.title)
                      .padding()
                      .background(Color.white)
                      .cornerRadius(8)
                      .overlay(
                          RoundedRectangle(cornerRadius: 8)
                              .stroke(Color.black, lineWidth: 1)
                      )
                  
                  // add description
                ZStack(alignment: .topLeading) {
                            ZStack {
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
                            
                            if draft.description.isEmpty {
                              Text("description: max 200 words")
                                .foregroundColor(Color.gray.opacity(0.5))
                                .padding(.horizontal, 12)
                                .padding(.vertical, 16)
                            }
                          }
                  
                  // category and color
                  HStack {
                      // Category picker
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
                  
                  // brand
                  TextField("brand", text: $draft.brand)
                      .padding()
                      .background(Color.white)
                      .cornerRadius(8)
                      .overlay(
                          RoundedRectangle(cornerRadius: 8)
                              .stroke(Color.black, lineWidth: 1)
                      )
                  
                // condition
                Text("condition: ")
                    .font(.system(size: 16))
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
                      
                      // price
                      TextField("price", text: Binding(
                          get: { String(draft.price) },
                          set: { draft.price = Double($0) ?? 0 }
                      ))
                      .padding()
                      .background(Color.white)
                      .cornerRadius(8)
                      .overlay(
                          RoundedRectangle(cornerRadius: 8)
                              .stroke(Color.black, lineWidth: 1)
                      )
                      Text("/ day")
                  }
                  
                // tags
                Text("tags (max 3):")
                    .font(.system(size: 16))
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
                .padding(.bottom, 10)
                
                Rectangle()
                  .fill(Color.gray.opacity(0.4))
                  .frame(height: 1)

                  
                  // navigation to next screen
                  NavigationLink(destination: MakeListingTwoView(user: user, draft: $draft)) {
                      Text("next")
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
                  .simultaneousGesture(TapGesture().onEnded {
                                uploadImagesAndContinue()
                            })
                  .frame(maxWidth: 200)
                  .frame(maxWidth: .infinity)
                  .padding(.top)
              }
              .padding()
          }
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

private func uploadImagesAndContinue() {
  let nonNilImages = uploadedImages.compactMap { $0 } // filter out nil images
  
  // call listingsviewmodel to upload images
  viewModel.uploadImages(nonNilImages) { urls in
    draft.photoURLs = urls
  }
}
}
