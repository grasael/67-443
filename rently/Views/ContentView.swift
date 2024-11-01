//
//  ContentView.swift
//  rently
//
//  Created by Grace Liao on 10/30/24.
//

import SwiftUI

struct ContentView: View {
    @StateObject private var chatViewModel = ChatViewModel()
    
    var body: some View {
        VStack {
            if chatViewModel.userCreated {
                Text("User created successfully!")
            } else {
                Text(chatViewModel.errorMessage ?? "Error.")
            }

            Button("Create User") {
                chatViewModel.createUser(
                    userId: "12345",
                    name: "John Doe",
                    email: "johndoe@example.com"
                )
            }
        }
        .padding()
    }
}
