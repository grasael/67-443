//
//  rentlyApp.swift
//  rently
//
//  Created by Grace Liao on 10/26/24.
//

import SwiftUI
<<<<<<< HEAD
import FirebaseCore

class AppDelegate: NSObject, UIApplicationDelegate {
  func application(_ application: UIApplication,
                   didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey : Any]? = nil) -> Bool {
    FirebaseApp.configure()

    return true
  }
}
=======
<<<<<<< HEAD
>>>>>>> main

@main
struct rentlyApp: App {
  // register app delegate for Firebase setup
  @UIApplicationDelegateAdaptor(AppDelegate.self) var delegate

  var body: some Scene {
    WindowGroup {
      NavigationView {
          ContentView()
      }
    }
<<<<<<< HEAD
  }
=======
=======
import FirebaseCore

class AppDelegate: NSObject, UIApplicationDelegate {
  func application(_ application: UIApplication,
                   didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey : Any]? = nil) -> Bool {
    FirebaseApp.configure()

    return true
  }
}

@main
struct rentlyApp: App {
  // register app delegate for Firebase setup
  @UIApplicationDelegateAdaptor(AppDelegate.self) var delegate

  var body: some Scene {
    WindowGroup {
      NavigationView {
        AppView()
//          ContentView()
      }
    }
  }
>>>>>>> fb9311cb1893bb33de0c13449a4d769f510984db
>>>>>>> main
}
