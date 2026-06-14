//
//  CardFavorite.swift
//  graspp
//
//  Created by Nadia Putri Natali Lubis on 13/06/26.
//

import SwiftUI

struct CardFavorite: View {
    
    let symbolName: String
    let articleTitle: String
    let categoryName: String
    let iconAccent: AnyShapeStyle
    
    @Environment(\.dynamicTypeSize) var dynamicTypeSize
    
    var singleLineHeight: CGFloat {
        UIFont.preferredFont(forTextStyle: .headline).lineHeight
    }
    
    var maxTextHeight: CGFloat {
        singleLineHeight * 2.2
    }
    
    var body: some View {
        VStack (alignment: .leading, spacing: 0){
            Image(systemName: symbolName)
                .font(.title2)
                .fontWeight(.medium)
                .foregroundStyle(iconAccent)
                .frame(width: dynamicTypeSize.isAccessibilitySize ? 64 : 52, height: dynamicTypeSize.isAccessibilitySize ? 64 : 52)
                .background(.ultraThinMaterial, in: Circle())
            Color.clear.frame(height: 16)
            
            VStack (alignment: .leading, spacing: 4){
                Text(articleTitle)
                    .font(.headline)
                    .lineLimit(2)
                    .layoutPriority(1)
                
                
                Text(categoryName)
                    .font(.callout)
                    .foregroundStyle(.secondary)
            }
            .fixedSize(horizontal: false, vertical: true)
                
        }
        .padding(16)
        .frame(width: 181)
        .frame(minHeight: 153)
        .glassEffect(.regular, in: RoundedRectangle(cornerRadius: 10))
    }
}

#Preview {
    CardFavorite(symbolName:"textformat", articleTitle:"Typeface vs Font long",categoryName:"Typography", iconAccent: AnyShapeStyle(.indigo)
    )
}
