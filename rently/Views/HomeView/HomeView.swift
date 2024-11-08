//
//  HomeView.swift
//  rently
//
//  Created by Grace Liao on 10/27/24.
//


import SwiftUI
import Foundation

struct HomeView: View {
  var body: some View {
    NavigationView {
      ScrollView {
        VStack(spacing: 30) {
          SearchBarView()
          ActiveRentalsView()
          KeepSearchingView()
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
