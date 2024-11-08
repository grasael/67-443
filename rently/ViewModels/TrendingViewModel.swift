//
//  TrendingViewModel.swift
//  rently
//
//  Created by Tishyaa Chaudhry on 11/4/24.
//

import SwiftUI
import FirebaseFirestore

class TrendingViewModel: ObservableObject {
    @Published var trendingItems: [TrendingItem] = []

    private var db = Firestore.firestore()

    func fetchTrendingItems() {
        print("Fetching trending items from Firestore...")  // Debug: Function called

        db.collection("Trending")
            .order(by: "priority")
            .getDocuments { snapshot, error in
                if let error = error {
                    print("Error fetching trending items: \(error)")  // Debug: Error case
                    return
                }

                guard let documents = snapshot?.documents else {
                    print("No documents found in the trending collection.")  // Debug: No documents case
                    return
                }

                print("Documents fetched: \(documents.count)")  // Debug: Documents count

                self.trendingItems = documents.compactMap { document in
                    do {
                        let item = try document.data(as: TrendingItem.self)
                        print("Fetched item: \(item.name), Priority: \(item.priority)")  // Debug: Each document
                        return item
                    } catch {
                        print("Error decoding document: \(error)")  // Debug: Decoding error
                        return nil
                    }
                }

                print("Total items after decoding: \(self.trendingItems.count)")  // Debug: Decoded items count
            }
    }
}
