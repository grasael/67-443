//
//  MakeListingView.swift
//  rently
//
//  Created by Abby Chen on 11/2/24.
//

import SwiftUI

struct MakeListingView: View {
  @Environment(\.presentationMode) var presentationMode
  @EnvironmentObject var viewModel: ListingsViewModel
  
  // state variables for form inputs
  @State private var title = ""
  @State private var description = ""
  @State private var category = ""
  @State private var brand = ""
  @State private var condition = ""
  @State private var size = ""
  @State private var price = ""
  @State private var color = ""
  @State private var tags: [String] = []
  @State private var nextScreen = false
  
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
              Text("category").tag("")
              Text("women's tops").tag("women's tops")
              Text("women's bottoms").tag("women's bottoms")
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
              Text("color").tag("")
              Text("black").tag("black")
              Text("red").tag("red")
              Text("orange").tag("orange")
              Text("yellow").tag("yellow")
              Text("green").tag("green")
              Text("blue").tag("blue")
              Text("purple").tag("purple")
              Text("pink").tag("pink")
              Text("brown").tag("brown")
              Text("cream").tag("cream")
              Text("white").tag("white")
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
              Text("size").tag("")
              Text("XS").tag("XS")
              Text("S").tag("S")
              Text("M").tag("M")
              Text("L").tag("L")
              Text("XL").tag("XL")
              Text("XXL").tag("XXL")
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
                if tags.contains(tag.rawValue) {
                  tags.removeAll { $0 == tag.rawValue }
                } else if tags.count < 3 {
                  tags.append(tag.rawValue)
                }
              }) {
                Text(tag.rawValue)
                  .padding(.vertical, 8)
                  .padding(.horizontal, 12)
                  .frame(minWidth: 100)
                  .lineLimit(1)
                  .background(tags.contains(tag.rawValue) ? Color("MediumGreen") : Color("LightGreen"))
                  .foregroundColor(.white)
                  .cornerRadius(20)
              }
              .disabled(tags.count >= 3 && !tags.contains(tag.rawValue))
            }
          }
          .padding(.bottom, 10)
          
          Rectangle()
            .fill(Color.gray.opacity(0.4))
            .frame(height: 1)
          
          
          // next button
          NavigationLink(
            destination: MakeListingTwoView(),
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
}

#Preview {
    MakeListingView()
}
