//
//  RecentlyViewedProgressive.swift
//  graspp
//
//  Created by Nadia Putri Natali Lubis on 14/06/26.
//

import SwiftUI

struct RecentlyViewedProgressive: View {
    
    let articles: [Article]
    let store: GrasppStore
    
    var body: some View {
        VStack (alignment: .leading, spacing: 14){
            // MARK: Section header
            HStack (spacing: 16){
                Text("Recently viewed")
                    .font(.title2)
                    .fontWeight(.bold)
                
                NavigationLink(value: RecentlyViewedDestination()) {
                    Image(systemName: "chevron.right")
                        .font(.title2)
                        .fontWeight(.bold)
                        .foregroundColor(.secondary)
                }
                
                Spacer()
            }
            .padding(.horizontal, 16)
            
            if articles.isEmpty {
                Text("Nothing viewed yet. Start exploring from Category.")
                    .font(.subheadline)
                    .foregroundStyle(.secondary)
                    .padding(.horizontal, 16)
            } else {
                // Max 5 items
                VStack(spacing: 8) {
                    ForEach(Array(articles.prefix(5))) { article in
                        NavigationLink(value: article) {
                            CardArticleCategory(
                                articleTitle: article.title,
                                categoryName: article.category?.name ?? "",
                                iconAccent: AnyShapeStyle(article.category?.color ?? .blue)
                            )
                        }
                        .buttonStyle(.plain)
                    }
                }
                .padding(.horizontal, 16)
            }
        }
    }
}

struct RecentlyViewedDestination: Hashable {}

//#Preview {
//    RecentlyViewedProgressive()
//}
