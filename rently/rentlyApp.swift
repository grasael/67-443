//
//  rentlyApp.swift
//  rently
//
//  Created by Grace Liao on 10/26/24.
//

import SwiftUI
<<<<<<< HEAD

@main
struct rentlyApp: App {
    var body: some Scene {
        WindowGroup {
            AppView()
        }
    }
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
}
