//
//  FirestoreMocks.swift
//  rently
//
//  Created by Sara Riyad on 12/5/24.
//

import Foundation
import FirebaseFirestore

// MARK: FirestoreMock
final class FirestoreMock: FirestoreProtocol {
    private var mockData: [String: Any] = [:]

    func mockDocument(_ path: String, snapshot: [String: Any]) {
        mockData[path] = snapshot
    }

    func mockQuery(_ collection: String, snapshot: TestMockQuerySnapshot) {
        mockData[collection] = snapshot.documents
    }

    func document(_ path: String) -> TestMockDocumentReference {
        return TestMockDocumentReference(data: mockData[path] as? [String: Any])
    }

    func collection(_ path: String) -> TestMockCollectionReference {
        let documents = mockData[path] as? [TestMockQueryDocumentSnapshot] ?? []
        return TestMockCollectionReference(documents: documents)
    }
}

// MARK: TestMockQuerySnapshot
final class TestMockQuerySnapshot {
    let documents: [TestMockQueryDocumentSnapshot]

    init(documents: [TestMockQueryDocumentSnapshot]) {
        self.documents = documents
    }
}

// MARK: TestMockQueryDocumentSnapshot
final class TestMockQueryDocumentSnapshot {
    private let data: [String: Any]

    init(data: [String: Any]) {
        self.data = data
    }

    func mockData() -> [String: Any] { // Renamed from data() to mockData()
        return data
    }
}

// MARK: TestMockDocumentReference
final class TestMockDocumentReference {
    private let data: [String: Any]?

    init(data: [String: Any]?) {
        self.data = data
    }

    func getDocument(completion: @escaping ([String: Any]?) -> Void) {
        completion(data)
    }
}

// MARK: TestMockCollectionReference
final class TestMockCollectionReference {
    private let documents: [TestMockQueryDocumentSnapshot]

    init(documents: [TestMockQueryDocumentSnapshot]) {
        self.documents = documents
    }

    func getDocuments(completion: @escaping (TestMockQuerySnapshot) -> Void) {
        completion(TestMockQuerySnapshot(documents: documents))
    }
}

protocol FirestoreProtocol {
    func collection(_ path: String) -> TestMockCollectionReference
    func document(_ path: String) -> TestMockDocumentReference
}
