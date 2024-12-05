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
    
    func testFetchUsersSuccess() {
        // Arrange: Mock Firestore data
        let mockData1: [String: Any] = ["id": "1", "firstName": "Grace", "lastName": "Liao", "email": "grace@example.com"]
        let mockData2: [String: Any] = ["id": "2", "firstName": "Sara", "lastName": "Riyad", "email": "sara@example.com"]
        let mockDocument1 = MockDocumentSnapshot(data: mockData1)
        let mockDocument2 = MockDocumentSnapshot(data: mockData2)

        let mockSnapshot = MockQuerySnapshot(documents: [mockDocument1, mockDocument2])
        let mockCollection = MockCollectionReference(mockSnapshot: mockSnapshot)
        let mockFirestore = MockFirestoreService(mockCollection: mockCollection)

        // Replace Firestore service in UserRepository with mock
        repository = UserRepository()

        // Act: Observe repository updates
        let expectation = XCTestExpectation(description: "Users should be updated")
        repository.$users
            .sink { users in
                if users.count == 2 {
                    expectation.fulfill()
                }
            }
            .store(in: &cancellables)

        // Assert: Wait for the results
        wait(for: [expectation])
        XCTAssertEqual(repository.users[0].firstName, "Grace")
        XCTAssertEqual(repository.users[1].firstName, "O")
    }


    func testFetchUsersFailure() {
        // Arrange: Mock Firestore error
        let mockCollection = MockCollectionReference(mockSnapshot: nil)
        let mockFirestore = MockFirestoreService(mockCollection: mockCollection)

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
