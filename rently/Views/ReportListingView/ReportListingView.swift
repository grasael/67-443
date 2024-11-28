//
//  ReportListingView.swift
//  rently
//
//  Created by Grace Liao on 11/28/24.
//

import Foundation
import SwiftUI

struct ReportListingView: View {
    @Environment(\.presentationMode) var presentationMode

    var body: some View {
        VStack(alignment: .leading) {
            HStack {
                Spacer()
                Text("report")
                    .font(.title2)
                    .fontWeight(.bold)
                Spacer()
            }
            .padding()
            
            VStack(alignment: .leading, spacing: 4) {
                Text("why are you reporting this listing?")
                    .font(.headline)
                Text("this won’t be shared with the owner")
                    .font(.subheadline)
                    .foregroundColor(.gray)
            }
            .padding(.horizontal)

            List {
                NavigationLink("counterfeit item", destination: CounterfeitReportView())
                NavigationLink("nudity, violence, or hate speech", destination: NVHReportView())
                NavigationLink("i just don’t like it", destination: DislikeReportView())
                NavigationLink("something else", destination: CustomReportView())
            }
            .listStyle(InsetGroupedListStyle())

            Spacer()
        }
        .navigationBarBackButtonHidden(false)
    }
}

struct ReportListingView_Previews: PreviewProvider {
    static var previews: some View {
        NavigationView {
            ReportListingView()
        }
    }
}
