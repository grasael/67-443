//
//  AppView.swift
//  rently
//
//  Created by Grace Liao on 10/27/24.
//

import SwiftUI

struct AppView: View {
    var body: some View {
        TabView {
<<<<<<< HEAD
          HomeView()
          .tabItem {
            Image(systemName: "house")
            Text("home")
          }
          SearchView()
          .tabItem {
            Image(systemName: "magnifyingglass")
            Text("search")
        }
          ListView()
          .tabItem {
            Image(systemName: "plus")
            Text("list")
        }
          RentalsView()
            .tabItem {
              Image(systemName: "hanger")
              Text("rentals")
        }
          ProfileView()
            .tabItem {
              Image(systemName: "person")
              Text("profile")
            }
        }
=======
         HomeView()
         .tabItem {
         Image(systemName: "house")
         Text("home")
         }
         SearchView()
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
         ProfileView()
         .tabItem {
         Image(systemName: "person")
         Text("profile")
         }
         }
>>>>>>> fb9311cb1893bb33de0c13449a4d769f510984db
    }
}

#Preview {
    AppView()
}
