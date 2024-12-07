//
//  AppView.swift
//  rently
//
//  Created by Grace Liao on 10/27/24.
//

import SwiftUI

struct AppView: View {
  let user: User
  @State private var searchText: String = "" // Track search text for the search view
  
  var body: some View {
    TabView {
      // Home View
      HomeView()
        .tabItem {
          Image(systemName: "house")
          Text("home")
        }
      
      // Search View with Binding to searchText
      SearchView(searchText: $searchText)
        .tabItem {
          Image(systemName: "magnifyingglass")
          Text("search")
        }
      
      // Make Listing View
      MakeListingView()
        .tabItem {
          Image(systemName: "plus")
          Text("list")
        }
      
      // Rentals View
      RentalsView()
        .tabItem {
          Image(systemName: "hanger")
          Text("rentals")
        }
      
      // Profile View
      ProfileView(user: user)
        .tabItem {
          Image(systemName: "person")
          Text("profile")
        }
    }
  }
}
