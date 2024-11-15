//
//  RentalHeaderView.swift
//  rently
//
//  Created by Tishyaa Chaudhry on 11/4/24.
//

import Foundation
import SwiftUI

struct RentalHeaderView: View {
    @Environment(\.presentationMode) var presentationMode
    
    var body: some View {
        HStack {
            Image(systemName: "chevron.left")
                .padding()
                .onTapGesture {
                    presentationMode.wrappedValue.dismiss()
                }
            Spacer()
            Text("Rental")
                .font(.headline)
            Spacer()
        }
        .padding(.horizontal)
    }
}
