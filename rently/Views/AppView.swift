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
        ProfileView(user: user)
         .tabItem {
         Image(systemName: "person")
         Text("profile")
         }
         }
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
