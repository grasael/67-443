//
//  HomeView.swift
//  rently
//
//  Created by Grace Liao on 10/27/24.
//


import SwiftUI
import Foundation

struct HomeView: View {
  let user: User
  var body: some View {
    NavigationView {
      ScrollView {
        VStack(spacing: 30) {
            SearchBarView(user: user)
          ActiveRentalsView()
//          KeepSearchingView() to be uncommented later
          SuggestedItemsView()
          TrendingSearchesView()
          
          Spacer()
        }
        .padding(.horizontal)
        .navigationBarHidden(true)
      }
    }
  }
  
  
}

#Preview {
    HomeView()
}
