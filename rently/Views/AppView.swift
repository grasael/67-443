//
//  AppView.swift
//  rently
//
//  Created by Grace Liao on 10/27/24.
//

import SwiftUI

struct AppView: View {
  @State private var selectedTab: Int = 0
  @StateObject private var listingsViewModel = ListingsViewModel()
  let user: User
    @StateObject private var userViewModel: UserViewModel

      init(user: User) {
          self.user = user
          _userViewModel = StateObject(wrappedValue: UserViewModel(user: user))
      }
  
  var body: some View {
        TabView(selection: $selectedTab) {
         HomeView()
           .tabItem {
             Image(systemName: "house")
             Text("home")
           }
           .tag(0)
         SearchView()
           .tabItem {
             Image(systemName: "magnifyingglass")
             Text("search")
           }
           .tag(1)
          MakeListingView(user: user, selectedTab: $selectedTab)
            .environmentObject(listingsViewModel)
            .environmentObject(userViewModel)
             .tabItem {
               Image(systemName: "plus")
               Text("list")
             }
             .tag(2)
         RentalsView()
            .tabItem {
               Image(systemName: "hanger")
               Text("rentals")
            }
            .tag(3)
         ProfileView(userViewModel: userViewModel)
            .tabItem {
               Image(systemName: "person")
               Text("profile")
            }
            .tag(4)
         }
    }
}
