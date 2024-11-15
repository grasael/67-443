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
<<<<<<< HEAD
=======
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
>>>>>>> main
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
<<<<<<< HEAD
        MakeListingView()
=======
         MakeListingView()
>>>>>>> main
         .tabItem {
         Image(systemName: "plus")
         Text("list")
         }
         RentalsView()
         .tabItem {
         Image(systemName: "hanger")
         Text("rentals")
         }
<<<<<<< HEAD
        ProfileView(user: user)
=======
         ProfileView()
>>>>>>> main
         .tabItem {
         Image(systemName: "person")
         Text("profile")
         }
         }
<<<<<<< HEAD
=======
>>>>>>> fb9311cb1893bb33de0c13449a4d769f510984db
>>>>>>> main
    }
}

#Preview {
    AppView(user: User(
        firstName: "Example",
        lastName: "User",
        username: "exampleuser",
        pronouns: "they/them",
        email: "example@domain.com",
        password: "password",
        university: "Example University",
        rating: 5.0,
        listings: [],
        likedItems: [],
        styleChoices: [],
        events: []
    ))
}
