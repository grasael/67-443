import SwiftUI

struct ListingView: View {
    let listing: Listing
    @EnvironmentObject var userViewModel: UserViewModel
    @State private var isLiked: Bool = false

    var body: some View {
        ScrollView {
            VStack(alignment: .leading, spacing: 16) {
                // Image Carousel
                TabView {
                    ForEach(listing.photoURLs, id: \.self) { photoURL in
                        AsyncImage(url: URL(string: photoURL)) { phase in
                            switch phase {
                            case .empty:
                                ProgressView()
                                    .frame(maxWidth: .infinity, maxHeight: 340)
                            case .success(let image):
                                image
                                    .resizable()
                                    .scaledToFit()
                                    .cornerRadius(10)
                                    .frame(maxWidth: .infinity, maxHeight: 340)
                            case .failure:
                                Image("sampleItemImage")
                                    .resizable()
                                    .scaledToFit()
                                    .cornerRadius(10)
                                    .frame(maxWidth: .infinity, maxHeight: 340)
                            @unknown default:
                                EmptyView()
                            }
                        }
                    }
                }
                .frame(height: 340) // Set fixed height for the carousel
                .tabViewStyle(PageTabViewStyle(indexDisplayMode: .automatic)) // Carousel style

                // Title and Heart Button
                HStack {
                    Text(listing.title)
                        .font(.title2)
                        .bold()
                        .foregroundColor(.primary)
                    Spacer()
                    Button(action: toggleLike) {
                        Image(systemName: isLiked ? "heart.fill" : "heart")
                            .font(.title2)
                            .foregroundColor(isLiked ? .red : .gray)
                    }
                }
                .padding(.horizontal)

                // Price
                Text("$\(String(format: "%.2f", listing.price)) / day")
                    .font(.headline)
                    .foregroundColor(.green)
                    .padding(.horizontal)

                // Brand, Condition, Size
                HStack {
                    Text(listing.brand)
                        .font(.subheadline)
                        .padding(.horizontal, 8)
                        .padding(.vertical, 4)
                        .background(Color.blue.opacity(0.2))
                        .cornerRadius(20)
                    Text(listing.condition.rawValue.capitalized)
                        .font(.subheadline)
                        .padding(.horizontal, 8)
                        .padding(.vertical, 4)
                        .background(Color.gray.opacity(0.2))
                        .cornerRadius(20)
                    Text("Size: \(listing.size.rawValue)")
                        .font(.subheadline)
                        .padding(.horizontal, 8)
                        .padding(.vertical, 4)
                        .background(Color.gray.opacity(0.2))
                        .cornerRadius(20)
                }
                .padding(.horizontal)

                // Description
                Text(listing.description)
                    .font(.body)
                    .padding(.horizontal)

                // Tags
                if !listing.tags.isEmpty {
                    HStack(spacing: 8) {
                        ForEach(listing.tags.prefix(3), id: \.self) { tag in
                            Text(tag.rawValue)
                                .font(.caption)
                                .padding(.horizontal, 8)
                                .padding(.vertical, 4)
                                .background(Color.blue.opacity(0.1))
                                .cornerRadius(20)
                        }
                    }
                    .padding(.horizontal)
                }

                // Price and Rent Button
                HStack {
                    Text("$\(String(format: "%.2f", listing.price))/day")
                        .font(.headline)
                        .foregroundColor(.primary)
                    Spacer()
                    Button(action: {
                        // Rent button functionality
                    }) {
                        Text("rent")
                            .font(.headline)
                            .padding()
                            .frame(maxWidth: .infinity)
                            .background(
                                LinearGradient(
                                    gradient: Gradient(colors: [Color("MediumBlue"), Color("LightGreen")]),
                                    startPoint: .leading,
                                    endPoint: .trailing
                                )
                            )
                            .cornerRadius(40)
                            .foregroundColor(.white)
                    }
                }
                .padding(.horizontal)
            }
            .padding(.bottom, 16) // Padding to avoid UI overlap
        }
        .onAppear {
            isLiked = userViewModel.user.likedItems.contains(listing.id ?? "")
        }
        .navigationBarTitle("Listing Details", displayMode: .inline)
    }

    private func toggleLike() {
        guard let listingID = listing.id else { return }
        if isLiked {
            // Unlike
            userViewModel.user.likedItems.removeAll { $0 == listingID }
        } else {
            // Like
            userViewModel.user.likedItems.append(listingID)
        }
        isLiked.toggle()
        // Update Firebase
        userViewModel.updateUser()
    }
}
