//
//  CardArticleList.swift
//  graspp
//
//  Created by Nadia Putri Natali Lubis on 15/06/26.
//

import SwiftUI

struct CardArticleList: View {
    let article: Article
    
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
                .foregroundStyle(article.category?.color ?? .blue)
            
            Color.clear.frame(width:14, height: 4)
            
            VStack (alignment: .leading, spacing: 4){
                Text(article.title)
                    .font(.headline)
                    .fontWeight(.semibold)
                    .lineLimit(2)
                    .layoutPriority(1)
                
                
                Text(article.summary)
                    .font(.caption)
                    .foregroundStyle(.secondary)
            }
            .fixedSize(horizontal: false, vertical: true)
            
            Spacer()
            
            Image(systemName: "chevron.right")
                .font(.callout)
                .foregroundStyle(.secondary)
                
        }
        .padding(16)
//        .frame(width: 370)
        .frame(minHeight: 66)
        .glassEffect(.regular, in: RoundedRectangle(cornerRadius: 10))
    }
}

#Preview {
    let article = Article(title: "Typeface vs Font", summary: "They are not the same.", body: "", hig: "", higSource: "")
    CardArticleList(article: article)
}
