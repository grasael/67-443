//
//  UserRepositoryTests.swift
//  rentlyTests
//
//  Created by Sara Riyad on 12/4/24.
//

import XCTest
import Combine
@testable import rently

// MARK: - Protocol Definitions
protocol FirestoreServiceProtocol {
    func collection(_ path: String) -> CollectionReferenceProtocol
}

protocol CollectionReferenceProtocol {
    func addSnapshotListener(_ listener: @escaping (QuerySnapshotProtocol?, Error?) -> Void)
}

protocol QuerySnapshotProtocol {
    var documents: [DocumentSnapshotProtocol] { get }
}

protocol DocumentSnapshotProtocol {
    func data() -> [String: Any]?
}

// MARK: - Tests for UserRepository
final class UserRepositoryTests: XCTestCase {
    private var repository: UserRepository!
    private var cancellables: Set<AnyCancellable>!

    override func setUp() {
        super.setUp()
        cancellables = []
    }

    override func tearDown() {
        repository = nil
        cancellables = nil
        super.tearDown()
    }


    func testFetchUsersFailure() {
        // Arrange: Mock Firestore error
        let mockCollection = MockCollectionReference(mockSnapshot: nil)
        _ = MockFirestoreService(mockCollection: mockCollection)

        // Replace Firestore service in UserRepository with mock
        repository = UserRepository()

        // Act: Observe repository updates
        let expectation = XCTestExpectation(description: "Users list should remain empty on failure")
        repository.$users
            .sink { users in
                if users.isEmpty {
                    expectation.fulfill()
                }
            }
            .store(in: &cancellables)

        // Assert: Wait for the results
        wait(for: [expectation], timeout: 1.0)
        XCTAssertEqual(repository.users.count, 0)
    }

}

// MARK: - Mock Classes
class MockFirestoreService: FirestoreServiceProtocol {
    private let mockCollection: MockCollectionReference

    init(mockCollection: MockCollectionReference) {
        self.mockCollection = mockCollection
    }

    func collection(_ path: String) -> CollectionReferenceProtocol {
        return mockCollection
    }
}

class MockCollectionReference: CollectionReferenceProtocol {
    private let mockSnapshot: QuerySnapshotProtocol?

    init(mockSnapshot: QuerySnapshotProtocol?) {
        self.mockSnapshot = mockSnapshot
    }

    func addSnapshotListener(_ listener: @escaping (QuerySnapshotProtocol?, Error?) -> Void) {
        if let snapshot = mockSnapshot {
            listener(snapshot, nil)
        } else {
            listener(nil, NSError(domain: "FirestoreError", code: -1, userInfo: nil))
        }
    }
}

class MockQuerySnapshot: QuerySnapshotProtocol {
    let documents: [DocumentSnapshotProtocol]

    init(documents: [DocumentSnapshotProtocol]) {
        self.documents = documents
    }
}

class MockDocumentSnapshot: DocumentSnapshotProtocol {
    private let mockData: [String: Any]

    init(data: [String: Any]) {
        self.mockData = data
    }

    func data() -> [String: Any]? {
        return mockData
    }
}
