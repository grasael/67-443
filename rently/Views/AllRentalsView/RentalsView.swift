//
//  RentalsView.swift
//  rently
//
//  Created by Grace Liao on 10/27/24.
//

import SwiftUI
import Combine
import FirebaseFirestore

struct RentalsView: View {
    @ObservedObject private var userManager = UserManager.shared // Observe the UserManager
    @State private var rentingItems: [(Rental, Listing)] = []
    @State private var myItems: [(Rental, Listing)] = []
    @State private var selectedTab = "renting"

    var body: some View {
        NavigationView {
            VStack {
                // Header
                Text("my rentals")
                    .font(.largeTitle)
                    .fontWeight(.bold)
                    .padding()

                // Tab Selector
                Picker("", selection: $selectedTab) {
                    Text("renting").tag("renting")
                    Text("my items").tag("myItems")
                }
                .pickerStyle(SegmentedPickerStyle())
                .padding()

                // List of Rentals
                ScrollView {
                    if selectedTab == "renting" {
                        ForEach(rentingItems, id: \.0.id) { (rental, listing) in
                            NavigationLink(destination: RentalDetailView(rental: rental)) {
                                RentalRowView(rental: rental, listing: listing, isCompleted: false)
                            }
                        }
                    } else {
                        if myItems.isEmpty {
                            // Placeholder View
                            VStack {
                                Image("Saly-45") // Use the image asset name
                                    .resizable()
                                    .scaledToFit()
                                    .frame(height: 200)
                                    .padding()

                                Text("Rent out your first item!")
                                    .font(.title2)
                                    .fontWeight(.semibold)
                                    .padding(.top)

                                Text("Click on the '+' to make a listing.")
                                    .font(.subheadline)
                                    .foregroundColor(.gray)
                            }
                            .padding()
                        } else {
                            ForEach(myItems, id: \.0.id) { (rental, listing) in
                                NavigationLink(destination: RentalDetailView(rental: rental)) {
                                    RentalRowView(rental: rental, listing: listing, isCompleted: true)
                                }
                            }
                        }
                    }
                }
            }
            .onAppear {
                fetchRentals()
            }
            .background( // Apply background gradient here
                            LinearGradient(
                                gradient: Gradient(colors: [Color("LightestBlue"), Color("LightGreen"),Color("Yellow")]),
                                startPoint: .topLeading,
                                endPoint: .bottomTrailing
                            )
                            .ignoresSafeArea() // Make sure it covers the entire screen
                        )
        }
    }

    // Fetch Rentals
    private func fetchRentals() {
        guard let user = userManager.user, let userID = user.id else {
            print("[DEBUG] No current user available")
            return
        }

        let db = Firestore.firestore()

        // Fetch User Data
        db.collection("Users").document(userID).getDocument { (document, error) in
            if let error = error {
                print("[DEBUG] Error fetching user document: \(error.localizedDescription)")
                return
            }

            guard let document = document, document.exists else {
                print("[DEBUG] User document does not exist")
                return
            }

            do {
                let user = try document.data(as: User.self)

                // Debug: Output IDs
                print("[DEBUG] User myItems IDs: \(user.myItems)")
                print("[DEBUG] User renting IDs: \(user.renting)")

                fetchRentalsAndListings(rentalIDs: user.myItems) { rentalsListings in
                    DispatchQueue.main.async {
                        myItems = rentalsListings
                        print("[DEBUG] Fetched myItems listings: \(rentalsListings.count)")
                    }
                }

                fetchRentalsAndListings(rentalIDs: user.renting) { rentalsListings in
                    DispatchQueue.main.async {
                        rentingItems = rentalsListings
                        print("[DEBUG] Fetched rentingItems listings: \(rentalsListings.count)")
                    }
                }
            } catch {
                print("[DEBUG] Error decoding user data: \(error.localizedDescription)")
            }
        }
    }

    // Fetch Rentals and their Listings
    private func fetchRentalsAndListings(rentalIDs: [String], completion: @escaping ([(Rental, Listing)]) -> Void) {
        let db = Firestore.firestore()

        guard !rentalIDs.isEmpty else {
            print("[DEBUG] No rental IDs provided to fetchRentalsAndListings")
            completion([])
            return
        }

        // Debug: Fetch Rentals
        print("[DEBUG] Fetching Rentals for IDs: \(rentalIDs)")

        db.collection("Rentals").whereField(FieldPath.documentID(), in: rentalIDs).getDocuments { (snapshot, error) in
            if let error = error {
                print("[DEBUG] Error fetching rentals: \(error.localizedDescription)")
                completion([])
                return
            }

            guard let snapshot = snapshot else {
                print("[DEBUG] No snapshot found for rentals")
                completion([])
                return
            }

            do {
                let rentals = try snapshot.documents.compactMap { try $0.data(as: Rental.self) }
                print("[DEBUG] Successfully fetched \(rentals.count) rentals")

                // Extract Listing IDs
                let listingIDs = rentals.map { $0.listingID }
                print("[DEBUG] Corresponding Listing IDs: \(listingIDs)")

                // Fetch Listings
                fetchListings(listingIDs: listingIDs) { listings in
                    var rentalsListings: [(Rental, Listing)] = []

                    // Pair Rentals with Listings
                    for (index, rental) in rentals.enumerated() {
                        if index < listings.count {
                            rentalsListings.append((rental, listings[index]))
                        }
                    }

                    completion(rentalsListings)
                }
            } catch {
                print("[DEBUG] Error decoding rentals: \(error.localizedDescription)")
                completion([])
            }
        }
    }

    // Fetch Listings by IDs
    private func fetchListings(listingIDs: [String], completion: @escaping ([Listing]) -> Void) {
        let db = Firestore.firestore()

        guard !listingIDs.isEmpty else {
            print("[DEBUG] No listing IDs provided to fetchListings")
            completion([])
            return
        }

        // Debug: Fetching Listings
        print("[DEBUG] Fetching Listings for IDs: \(listingIDs)")

        db.collection("Listings").whereField(FieldPath.documentID(), in: listingIDs).getDocuments { (snapshot, error) in
            if let error = error {
                print("[DEBUG] Error fetching listings: \(error.localizedDescription)")
                completion([])
                return
            }

            guard let snapshot = snapshot else {
                print("[DEBUG] No snapshot found for listings")
                completion([])
                return
            }

            do {
                let listings = try snapshot.documents.compactMap { try $0.data(as: Listing.self) }
                print("[DEBUG] Successfully fetched \(listings.count) listings")
                completion(listings)
            } catch {
                print("[DEBUG] Error decoding listings: \(error.localizedDescription)")
                completion([])
            }
        }
    }
}

