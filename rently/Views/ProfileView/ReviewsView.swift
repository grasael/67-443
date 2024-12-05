//
//  ReviewsView.swift
//  rently
//
//  Created by Grace Liao on 11/7/24.
//
import SwiftUI

struct ReviewsView: View {
    @StateObject private var viewModel = ReviewRepository()
    @State private var selectedTab: Tab = .received
    
    var body: some View {
        VStack {
            HStack {
                Button(action: {
                    selectedTab = .received
                }) {
                    Text("reviews received")
                        .padding()
                        .frame(maxWidth: .infinity)
                        .background(selectedTab == .received ? Color.blue.opacity(0.2) : Color.clear)
                        .cornerRadius(10)
                }
                Button(action: {
                    selectedTab = .myReviews
                }) {
                    Text("my reviews")
                        .padding()
                        .frame(maxWidth: .infinity)
                        .background(selectedTab == .myReviews ? Color.blue.opacity(0.2) : Color.clear)
                        .cornerRadius(10)
                }
            }
            .frame(height: 40)
            .padding(.horizontal)
            
            ScrollView {
                VStack(spacing: 16) {
                    ForEach(filteredReviews) { review in
                        ReviewRow(review: review)
                    }
                }
                .padding()
            }
        }
        .navigationTitle("reviews")
        .onAppear {
            viewModel.get()
        }
    }
    
    private var filteredReviews: [Review] {
        if selectedTab == .received {
            return viewModel.reviews
        } else {
            return viewModel.reviews.filter { $0.userID == "currentUserID" }
        }
    }
}

struct ReviewRow: View {
    let review: Review
    
    var body: some View {
        HStack(spacing: 16) {
            Image(systemName: "person.crop.circle.fill")
                .resizable()
                .frame(width: 40, height: 40)
                .clipShape(Circle())
            
            VStack(alignment: .leading, spacing: 4) {
                Text(review.userID)
                    .font(.headline)
                Text(review.time, style: .date)
                    .font(.subheadline)
                    .foregroundColor(.gray)
                Text(review.text)
                    .font(.body)
                    .padding(.top, 4)
            }
            
            Spacer()
            
            Image("item_placeholder")
                .resizable()
                .frame(width: 60, height: 60)
                .cornerRadius(10)
        }
        .padding()
        .background(Color.white)
        .cornerRadius(10)
        .shadow(radius: 1)
    }
}

// Enum for managing tabs
enum Tab {
    case received
    case myReviews
}

// Preview
struct ReviewsView_Previews: PreviewProvider {
    static var previews: some View {
        NavigationView {
            ReviewsView()
        }
    }
}
