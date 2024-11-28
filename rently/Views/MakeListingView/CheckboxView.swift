//
//  CheckboxView.swift
//  rently
//
//  Created by Abby Chen on 11/7/24.
//

import Foundation
import SwiftUI

struct CheckboxView: View {
  @Binding var isChecked: Bool
  var label: String
      
  var body: some View {
    HStack {
      Image(systemName: isChecked ? "checkmark.square.fill" : "square")
        .resizable()
        .frame(width: 24, height: 24)
        .foregroundColor(isChecked ? Color("MediumBlue") : .gray)
        .onTapGesture {
          isChecked.toggle()
        }
      Text(label)
    }
  }
}
