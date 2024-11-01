//
//  TalkJSService.swift
//  rently
//
//  Created by Grace Liao on 10/30/24.
//

import Foundation

class TalkJSService {
    private let appId = ""
    private let secretKey = ""
    
    func createUser(userId: String, name: String, email: String, completion: @escaping (Result<Void, Error>) -> Void) {
        let url = URL(string: "https://api.talkjs.com/v1/\(appId)/users/\(userId)")!
        var request = URLRequest(url: url)
        request.httpMethod = "PUT"
        request.addValue("Bearer \(secretKey)", forHTTPHeaderField: "Authorization")
        request.addValue("application/json", forHTTPHeaderField: "Content-Type")
        
        let user: [String: Any] = [
            "id": userId,
            "name": name,
            "email": email,
            "welcomeMessage": "Hi there!"
        ]
        
        request.httpBody = try? JSONSerialization.data(withJSONObject: user, options: [])
        
        let task = URLSession.shared.dataTask(with: request) { data, response, error in
            if let error = error {
                completion(.failure(error))
                return
            }
            completion(.success(()))
        }
        task.resume()
    }
}
