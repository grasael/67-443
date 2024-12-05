//
//  AppView.swift
//  rently
//
//  Created by Grace Liao on 10/27/24.
//

import SwiftUI

struct AppView: View {
    @StateObject var userViewModel: UserViewModel

    var body: some View {
        TabView {
            HomeView()
                .tabItem {
                    Image(systemName: "house")
                    Text("home")
                }
            SearchView(userViewModel: userViewModel)
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
            ProfileView(userViewModel: userViewModel)
                .tabItem {
                    Image(systemName: "person")
                    Text("profile")
                }
        }
    }
}
