import SwiftUI

import SwiftUI

struct RentalRowView: View {
    var rental: Rental
    var listing: Listing
    var isCompleted: Bool

    var body: some View {
        HStack {
            // Image
            if let imageUrl = listing.photoURLs.first {
                AsyncImage(url: URL(string: imageUrl)) { image in
                    image.resizable()
                        .scaledToFill()
                        .frame(width: 50, height: 50)
                        .clipShape(Rectangle())
                        .cornerRadius(8)
                } placeholder: {
                    Color.gray
                        .frame(width: 50, height: 50)
                        .cornerRadius(8)
                }
            }
            
            // Text Details
            VStack(alignment: .leading, spacing: 5) {
                Text(listing.title)
                    .font(.headline)
                
                // Format start and end dates
                Text("\(formattedDate(rental.startDate)) - \(formattedDate(rental.endDate))")
                    .font(.subheadline)
                    .foregroundColor(.gray)
            }
            
            Spacer()
            
            // Completion Tag
            if isCompleted {
                Text("completed")
                    .font(.caption)
                    .foregroundColor(.gray)
                    .padding(5)
                    .background(Color.gray.opacity(0.2))
                    .cornerRadius(8)
            }
        }
        .padding(.horizontal, 20)
        .padding(.vertical, 10) // Optional: add vertical padding as well
        .background(Color.white) // Ensure a background is there to hold the border
        .cornerRadius(10) // Apply corner radius to the background
        .overlay( // Apply border using overlay
            RoundedRectangle(cornerRadius: 10)
                .stroke(Color.black, lineWidth: 0.5)
        )
        .padding() // Add padding outside the outline
    }
    
    // Format dates as strings
    private func formattedDate(_ date: Date) -> String {
        let dateFormatter = DateFormatter()
        dateFormatter.dateStyle = .short
        return dateFormatter.string(from: date)
    }
}

struct RentalRowView_Previews: PreviewProvider {
    static var previews: some View {
        // Sample Rental and Listing Data
        let sampleListing = Listing(
            id: "1",
            title: "Red Dress",
            creationTime: Date(),
            description: "A beautiful red dress perfect for parties.",
            category: .dresses,
            userID: "user123",
            size: .medium,
            price: 49.99,
            color: .red,
            condition: .brandNew,
            photoURLs: ["https://example.com/image.jpg"],
            tags: [.party, .formal],
            brand: "Brand A",
            maxRentalDuration: .oneMonth,
            pickupLocations: [.uc],
            available: true
        )

        let sampleRental = Rental(
            id: "1",
            renteeID: "rentee123",
            renterID: "renter123",
            startDate: Calendar.current.date(byAdding: .day, value: 1, to: Date())!,
            endDate: Calendar.current.date(byAdding: .day, value: 7, to: Date())!,
            pickupLocation: "Jared L. Cohon University Center",
            listingID: sampleListing.id!,
            message: "Looking forward to this rental!",
            status: "active"
        )

        // Preview for RentalRowView
        RentalRowView(rental: sampleRental, listing: sampleListing, isCompleted: true)
            .previewLayout(.sizeThatFits)
            .padding()
    }
}
