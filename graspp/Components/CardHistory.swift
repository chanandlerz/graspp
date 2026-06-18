//
//  CardHistory.swift
//  graspp
//
//  Created by Nadia Putri Natali Lubis on 15/06/26.
//

import SwiftUI

struct CardHistory: View {
    let article : Article
//    let articleTitle: String
//    let categoryName: String
//    let iconAccent: AnyShapeStyle
    
    @Environment(\.dynamicTypeSize) var dynamicTypeSize
    
    var singleLineHeight: CGFloat {
        UIFont.preferredFont(forTextStyle: .headline).lineHeight
    }
    
    var maxTextHeight: CGFloat {
        singleLineHeight * 2.2
    }
    
    var body: some View {
        HStack (spacing: 0){
            Image(systemName: "clock.arrow.trianglehead.counterclockwise.rotate.90")
                .font(.callout)
                .foregroundStyle(.secondary)
            
            Color.clear.frame(width:14, height: 4)
            
            VStack (alignment: .leading, spacing: 4){
                Text(article.title)
                    .font(.headline)
                    .fontWeight(.semibold)
                    .lineLimit(2)
                    .layoutPriority(1)
                
                
                Text(article.category?.name ?? "")
                    .font(.subheadline)
                    .foregroundStyle(.secondary)
            }
            .fixedSize(horizontal: false, vertical: true)
            
            Spacer()
                
        }
        .padding(16)
        .frame(width: 370)
        .frame(minHeight: 66)
        .glassEffect(.regular, in: RoundedRectangle(cornerRadius: 10))
    }
}

#Preview {
    CardHistory(article: sampleArticle)
}
