//
//  EditListingView.swift
//  rently
//
//  Created by Abby Chen on 12/5/24.
//

import Foundation
import Combine
import SwiftUI

struct EditListingView: View {
    let listing: Listing
    var body: some View {
        Text("Edit Listing View for \(listing.title)")
    }
}
