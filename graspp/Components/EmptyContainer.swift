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
        VStack (spacing: 16) {
            Image(systemName: symbol)
                .font(.largeTitle)
                .foregroundStyle(.secondary)
            VStack {
                Text(headline)
                    .font(.headline)
                    .foregroundStyle(.secondary)
                Text(subHeadline)
                    .font(.subheadline)
                    .foregroundStyle(.secondary)

            }
        }
        .frame(maxWidth: .infinity)
        .padding(16)
    }
}

#Preview {
    EmptyContainer(symbol: "star.slash", headline: "No favorites yet.", subHeadline: "Tap the star icon on any article.")
}
