//
//  EmptyContainer.swift
//  graspp
//
//  Created by Nadia Putri Natali Lubis on 18/06/26.
//

import SwiftUI

struct EmptyContainer: View {
    let symbol: String
    let headline: String
    let subHeadline: String
    
    var body: some View {
        VStack (alignment: .center, spacing: 16) {
            Image(systemName: symbol)
                .font(.largeTitle)
                .foregroundStyle(.secondary)
            VStack (alignment: .center){
                Text(headline)
                    .font(.headline)
                    .foregroundStyle(.secondary)
                Text(subHeadline)
                    .font(.subheadline)
                    .foregroundStyle(.secondary)
                    .multilineTextAlignment(.center)

            }
        }
        .padding(16)
        .frame(maxWidth: .infinity, alignment: .center)
    }
}

#Preview {
    EmptyContainer(symbol: "star.slash", headline: "No favorites yet.", subHeadline: "Browse an article from Category, then tap ★ to save it here.")
}
