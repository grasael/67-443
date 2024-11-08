//
//  MakeListingView.swift
//  rently
//
//  Created by Abby Chen on 11/2/24.
//

import SwiftUI
import PhotosUI

struct MakeListingView: View {
  @Environment(\.presentationMode) var presentationMode
  @EnvironmentObject var viewModel: ListingsViewModel
  
  // state variables for form inputs
  @State private var title = ""
  @State private var description = ""
  @State private var category: Category = .womensTops
  @State private var brand = ""
  @State private var condition = ""
  @State private var size: ItemSize = .xxsmall
  @State private var price = ""
  @State private var color: ItemColor = .red
  @State private var tags: [TagOption] = []
  @State private var nextScreen = false
  
  // photo selection
  @State private var selectedImages: [PhotosPickerItem] = []
  // loaded images
  @State private var uploadedImages: [UIImage] = []
  
  let user: User
  
  var body: some View {
    NavigationView {
      ScrollView {
        VStack(alignment: .leading, spacing: 16) {
          // cancel button
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
          
          // page title
          Text("make a listing")
            .font(/*@START_MENU_TOKEN@*/.title/*@END_MENU_TOKEN@*/)
            .bold()
          
          // upload photos
          Text("upload photos (max 4):")
            .font(.system(size: 16))
          
          // placeholders for up to 4 photos
          LazyVGrid(columns: Array(repeating: GridItem(.flexible(), spacing: 10), count: 4), spacing: 10) {
            ForEach(0..<4, id: \.self) { index in
              if index < uploadedImages.count {
                Image(uiImage: uploadedImages[index])
                  .resizable()
                  .scaledToFill()
                  .frame(width: 80, height: 80)
                  .clipShape(RoundedRectangle(cornerRadius: 10))
                  .overlay(
                    RoundedRectangle(cornerRadius: 10)
                      .stroke(Color.black, lineWidth: 1)
                  )
              } else {
                PhotosPicker(selection: $selectedImages, maxSelectionCount: 1, matching: .images) {
                  ZStack {
                    RoundedRectangle(cornerRadius: 10)
                      .stroke(Color.black, lineWidth: 1)
                      .frame(width: 80, height: 80)
                                                  
                    Image(systemName: "plus")
                      .foregroundColor(.gray)
                  }
                }
                .onChange(of: selectedImages) { newItems in
                  loadSelectedPhotos(from: newItems)
                }
              }
            }
          }
          
          // add title
          TextField("title", text: $title)
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
              
              TextEditor(text: $description)
                .frame(height: 100)
                .padding(4)
                .background(Color.clear)
                .cornerRadius(8)
                .overlay(
                  RoundedRectangle(cornerRadius: 8)
                    .stroke(Color.black, lineWidth: 1)
                )
            }
            
            if description.isEmpty {
              Text("description: max 200 words")
                .foregroundColor(Color.gray.opacity(0.5))
                .padding(.horizontal, 12)
                .padding(.vertical, 16)
            }
          }
          
          // category and color
          HStack {
            // category
            Picker("category", selection: $category) {
              ForEach(Category.allCases, id: \.self) { category in Text(category.rawValue).tag(category)
              }
            }
            .pickerStyle(MenuPickerStyle())
            .padding(.vertical, 4)
            .padding(.horizontal, 8)
            .background(Color.white)
            .cornerRadius(8)
            .overlay(
              RoundedRectangle(cornerRadius: 8)
                .stroke(Color.black, lineWidth: 1)
            )
            
            // color
            Picker("color", selection: $color) {
              ForEach(ItemColor.allCases, id: \.self) {
                color in Text(color.rawValue).tag(color)
              }
            }
            .pickerStyle(MenuPickerStyle())
            .padding(.vertical, 4)
            .padding(.horizontal, 8)
            .background(Color.white)
            .cornerRadius(8)
            .overlay(
              RoundedRectangle(cornerRadius: 8)
                .stroke(Color.black, lineWidth: 1)
            )
          }
          
          // brand
          TextField("brand", text: $brand)
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
            ForEach(["brand new", "very good", "good", "fair"], id: \.self) { conditionOption in Button(action: {
              condition = conditionOption
            }) {
              Text(conditionOption)
                .padding(9)
                .background(condition == conditionOption ? Color.gray.opacity(0.9) : Color.gray.opacity(0.4))
                .cornerRadius(20)
                .foregroundColor(.white)
            }
            }
          }
          
          // size and price
          HStack {
            // size
            Picker("size", selection: $size) {
              ForEach(ItemSize.allCases, id: \.self) { size in Text(size.rawValue).tag(size)
              }
            }
            .pickerStyle(MenuPickerStyle())
            .padding(.vertical, 4)
            .padding(.horizontal, 8)
            .background(Color.white)
            .cornerRadius(8)
            .overlay(
              RoundedRectangle(cornerRadius: 8)
                .stroke(Color.black, lineWidth: 1)
            )
            
            // price
            TextField("price", text: $price)
              .padding(.vertical, 10)
              .padding(.horizontal, 8)
              .background(Color.white)
              .cornerRadius(8)
              .overlay(
                RoundedRectangle(cornerRadius: 8)
                  .stroke(Color.black, lineWidth: 1)
              )
            
            Text("/ day")
              .padding(.leading, 4)
          }
          
          // tags
          Text("tags (max 3):")
              .font(.system(size: 16))
          LazyVGrid(columns: [GridItem(.adaptive(minimum: 100), spacing: 10)], spacing: 10) {
              ForEach(TagOption.allCases, id: \.self) { tag in
                  Button(action: {
                      if tags.contains(tag) {
                          tags.removeAll { $0 == tag }
                      } else if tags.count < 3 {
                          tags.append(tag)
                      }
                  }) {
                      Text(tag.rawValue)
                          .padding(.vertical, 8)
                          .padding(.horizontal, 12)
                          .frame(minWidth: 100)
                          .lineLimit(1)
                          .background(tags.contains(tag) ? Color("MediumGreen") : Color("LightGreen"))
                          .foregroundColor(.white)
                          .cornerRadius(20)
                  }
                  .disabled(tags.count >= 3 && !tags.contains(tag))
              }
          }
          .padding(.bottom, 10)
          
          Rectangle()
            .fill(Color.gray.opacity(0.4))
            .frame(height: 1)
          
          
          // next button
          NavigationLink(
            destination: MakeListingTwoView(user: user),
            isActive: $nextScreen
          ) {
            Text("next")
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
    }
  }
  
  // helper function to load photos
  func loadSelectedPhotos(from items: [PhotosPickerItem]) {
    Task {
      // clear previous images
      uploadedImages.removeAll()
      for item in items {
        if let data = try? await item.loadTransferable(type: Data.self),
           let image = UIImage(data: data) {
          // add loaded image
          uploadedImages.append(image)
        }
      }
    }
  }
}

#Preview {
    MakeListingView(user: User(
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
