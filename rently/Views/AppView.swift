//
//  AppView.swift
//  rently
//
//  Created by Grace Liao on 10/27/24.
//

import SwiftUI

struct AppView: View {
  let user: User
  var body: some View {
        TabView {
            HomeView(user: user)
         .tabItem {
         Image(systemName: "house")
         Text("home")
         }
         SearchView(query: "")
         .tabItem {
         Image(systemName: "magnifyingglass")
         Text("search")
         }
         MakeListingView()
         .tabItem {
         Image(systemName: "plus")
         Text("list")
         }
         RentalsView()
         .tabItem {
         Image(systemName: "hanger")
         Text("rentals")
         }
          ProfileView(user: user)
         .tabItem {
         Image(systemName: "person")
         Text("profile")
         }
         }
    }
}

