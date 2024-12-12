//
//  AppView.swift
//  rently
//
//  Created by Grace Liao on 10/27/24.
//

import SwiftUI

struct AppView: View {
  @State private var selectedTab: Int = 0
  @StateObject var listingsViewModel = ListingsViewModel()
  @StateObject var viewModel: UserViewModel

  var body: some View {
        TabView(selection: $selectedTab) {
            HomeView()
                .environmentObject(viewModel) // Provide UserViewModel
                .environmentObject(listingsViewModel) // Provide ListingsViewModel
                .tabItem {
                    Image(systemName: "house")
                    Text("home")
                }
                .tag(0)
         SearchView(userViewModel: viewModel)
           .tabItem {
             Image(systemName: "magnifyingglass")
             Text("search")
           }
           .tag(1)
          MakeListingView(selectedTab: $selectedTab)
            .environmentObject(listingsViewModel)
            .environmentObject(viewModel)
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
         ProfileView(userViewModel: viewModel)
            .tabItem {
               Image(systemName: "person")
               Text("profile")
            }
            .tag(4)
         }
    }
}
