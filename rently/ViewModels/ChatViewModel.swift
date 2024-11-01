//
//  ChatViewModel.swift
//  rently
//
//  Created by Grace Liao on 10/30/24.
//

import Combine
import Foundation
import Dispatch

class ChatViewModel: ObservableObject {
    @Published var userCreated = false
    @Published var errorMessage: String?

    private let talkJSService = TalkJSService()
    
    func createUser(userId: String, name: String, email: String) {
        talkJSService.createUser(userId: userId, name: name, email: email) { result in
            DispatchQueue.main.async {
                switch result {
                case .success:
                    self.userCreated = true
                    self.errorMessage = nil
                case .failure(let error):
                    self.userCreated = false
                    self.errorMessage = "Failed to create user: \(error.localizedDescription)"
                }
            }
        }
    }
}
