//
//  HelpView.swift
//  rently
//
//  Created by Sara Riyad on 12/12/24.
//


import SwiftUI

struct HelpView: View {
    var body: some View {
        ScrollView {
            VStack(alignment: .leading, spacing: 20) {
                SectionHeader(title: "what is rently?")
                Text("rently is an app by college students, for college students, promoting slow fashion and campus community. we aim to create a space where students can share styles, save money, and embrace sustainability through clothing rentals ♻️")
                    .padding(.horizontal)
                
                SectionHeader(title: "how do i rent an item?")
                VStack(alignment: .leading, spacing: 10) {
                    Text("1. browse and select: choose the item you want to rent from the available listings. tap on the rent button to begin.")
                    Text("2. provide details: fill out the rental form, select your desired dates, and choose a pickup location.")
                    Text("3. communicate with the owner: message the item’s owner to coordinate a convenient pickup time.")
                    Text("4. pickup and initial payment: meet with the owner, pay half of the rental price, and collect the item.")
                    Text("5. verify the pickup: complete a short form to confirm the pickup and the item’s condition.")
                    Text("6. return the item: on the selected return date, meet the owner to return the item and pay the remaining balance.")
                    Text("7. leave a review: rate the item and its owner to help others in the community.")
                }
                .padding(.horizontal)
                
                SectionHeader(title: "what items are available?")
                Text("any type of clothing! from activewear to formalwear! but no shoes or accessories.. maybe in the future though 👀")
                    .padding(.horizontal)
                
                SectionHeader(title: "how do i find an item to rent?")
                VStack(alignment: .leading, spacing: 10) {
                    Text("1. navigate to the search tab in the app")
                    Text("2. use the search bar to look for specific items, colors, or categories")
                    Text("3. apply filters to narrow down your options")
                    Text("4. tap on a listing to view more details")
                    Text("5. happy renting!")
                }
                .padding(.horizontal)
                
                SectionHeader(title: "how do i contact the owner of an item?")
                Text("open the listing and tap the message owner button next to the mail icon.")
                    .padding(.horizontal)
                
                SectionHeader(title: "what happens if an item is damaged during rental?")
                VStack(alignment: .leading, spacing: 10) {
                    Text("1. report the issue in the form in your rentals tab")
                    Text("2. provide a description and photo")
                    Text("3. the app’s team will review and mediate to determine next steps")
                }
                .padding(.horizontal)
            }
            .padding(.top)
            .navigationTitle("help")
            .navigationBarTitleDisplayMode(.inline)
        }
    }
}