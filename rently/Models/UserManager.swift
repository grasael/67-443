//
//  UserManager.swift
//  rently
//
//  Created by Tishyaa Chaudhry on 12/5/24.
//

import Foundation
import SwiftUI
import Combine

class UserManager: ObservableObject {
    static let shared = UserManager()
    
    @Published var user: User?

    private init() {
        // You can add any setup code here, such as loading a user from persistent storage or Firestore.
    }

    func saveUser(_ user: User) {
        self.user = user
    }

    func clearUser() {
        self.user = nil
    }
}
