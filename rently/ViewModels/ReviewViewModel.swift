//
//  ReviewViewModel.swift
//  rently
//
//  Created by Grace Liao on 11/7/24.
//
//
//  ReviewViewModel.swift
//  rently
//
//  Created by Grace Liao on 11/7/24.
//
import Foundation
import Combine

class ReviewViewModel: ObservableObject, Identifiable {
    private let reviewRepository = ReviewRepository()
    @Published var review: Review
    private var cancellables: Set<AnyCancellable> = []
    var id = ""

    init(review: Review) {
        self.review = review
        $review
            .compactMap { $0.id }
            .assign(to: \.id, on: self)
            .store(in: &cancellables)
    }

    func addReview() {
        reviewRepository.create(review)
    }

    func updateReview() {
        reviewRepository.update(review)
    }

    func deleteReview() {
        reviewRepository.delete(review)
    }
}
