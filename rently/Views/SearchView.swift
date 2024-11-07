//
//  SearchView.swift
//  rently
//
//  Created by Grace Liao on 10/27/24.
//

import SwiftUI

struct SearchView: View {
  var body: some View {
        VStack {
            Text("This is the search page.")
        }
        .padding()
        .onAppear {
            // Call populateListings() when the view appears
//           populateListings()
        }
    }
}

#Preview {
    SearchView()
}
