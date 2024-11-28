//
//  UserViewModel.swift
//  rently
//
//  Created by Grace Liao on 11/1/24.
//

import Foundation
import Combine

class UserViewModel: ObservableObject, Identifiable {
    private let userRepository = UserRepository()
    @Published var user: User
    private var cancellables: Set<AnyCancellable> = []
    var id = ""

    init(user: User) {
        self.user = user
      print("DEBUG: UserViewModel initialized with user ID: \(user.id ?? "nil")")
        $user
            .compactMap { $0.id }
            .assign(to: \.id, on: self)
            .store(in: &cancellables)
    }

  func addUser(completion: @escaping () -> Void = {}) {
      userRepository.create(user) { newUser in
          DispatchQueue.main.async {
              self.user = newUser // Update the user object with the correct ID
            self.id = newUser.id ?? "" // Explicitly set UserViewModel.id
            print("DEBUG: User updated with ID: \(newUser.id ?? "nil")")
              completion() // Signal that the operation is complete
          }
      }
  }


    func updateUser() {
        userRepository.update(user)
    }

    func deleteUser() {
        userRepository.delete(user)
    }
}
