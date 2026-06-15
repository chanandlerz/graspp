//
//  CardArticleCategory.swift
//  graspp
//
//  Created by Nadia Putri Natali Lubis on 14/06/26.
//


import SwiftUI

struct CardArticleCategory: View {
    
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
        HStack (spacing: 0){
            Image(systemName: "circle.fill")
                .font(.caption2)
                .foregroundStyle(iconAccent)
//                .frame(width: dynamicTypeSize.isAccessibilitySize ? 64 : 52, height: dynamicTypeSize.isAccessibilitySize ? 64 : 52)
//                .background(.ultraThinMaterial, in: Circle())
            Color.clear.frame(width:14, height: 4)
            
            VStack (alignment: .leading, spacing: 4){
                Text(articleTitle)
                    .font(.headline)
                    .fontWeight(.semibold)
                    .lineLimit(2)
                    .layoutPriority(1)
                
                
                Text(categoryName)
                    .font(.subheadline)
                    .foregroundStyle(.secondary)
            }
            .fixedSize(horizontal: false, vertical: true)
            
            Spacer()
            
            Image(systemName: "chevron.right")
                .font(.callout)
                .foregroundStyle(.secondary)
                
        }
        .padding(16)
        .frame(width: 370)
        .frame(minHeight: 66)
        .glassEffect(.regular, in: RoundedRectangle(cornerRadius: 10))
    }
}

#Preview {
    CardArticleCategory(articleTitle:"Typeface vs Font long",categoryName:"Typography", iconAccent: AnyShapeStyle(.indigo)
    )
}
