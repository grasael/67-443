//
//  ShareListingView.swift
//  rently
//
//  Created by Grace Liao on 11/28/24.
//

import Foundation
import SwiftUI

struct ShareListingView: View {
    var body: some View {
        VStack(spacing: 20) {
            Text("Share this listing")
                .font(.title)
                .padding()

            HStack(spacing: 40) {
                Button(action: {
                    print("Share on Facebook")
                }) {
                    Image(systemName: "f.square")
                        .resizable()
                        .frame(width: 50, height: 50)
                        .foregroundColor(.blue)
                }

                Button(action: {
                    print("Share on Twitter")
                }) {
                    Image(systemName: "t.square")
                        .resizable()
                        .frame(width: 50, height: 50)
                        .foregroundColor(.blue)
                }

                Button(action: {
                    print("Share on Instagram")
                }) {
                    Image(systemName: "camera")
                        .resizable()
                        .frame(width: 50, height: 50)
                        .foregroundColor(.purple)
                }
            }
            .padding()
        }
    }
}

struct ShareListingView_Previews: PreviewProvider {
    static var previews: some View {
        ShareListingView()
    }
}
