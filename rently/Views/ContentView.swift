//
//  ContentView.swift
//  rently
//
//  Created by Grace Liao on 11/2/24.
//
//
//import SwiftUI
//
//struct ContentView: View {
//    @StateObject private var viewModel = UserViewModel()
//
//    var body: some View {
//        NavigationView {
//            if viewModel.isLoading {
//                VStack {
//                    ProgressView()
//                    Text("Loading data...")
//                        .padding(.top, 10)
//                }
//            } else if viewModel.users.isEmpty {
//                VStack {
//                    Text("No users available")
//                        .font(.title)
//                        .foregroundColor(.gray)
//                }
//            } else {
//                List(viewModel.users) { user in
//                    VStack(alignment: .leading) {
//                        Text(user.firstName)
//                            .font(.headline)
//                        Text(user.lastName)
//                            .font(.subheadline)
//                    }
//                }
//                .navigationTitle("Users")
//            }
//        }
//        .onAppear {
//            viewModel.fetchData()
//        }
//    }
//}
//
//#Preview {
//    ContentView()
//}
