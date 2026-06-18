//
//  FavoritesProgressive.swift
//  graspp
//
//  Created by Nadia Putri Natali Lubis on 13/06/26.
//

import SwiftUI

struct FavoritesProgressive: View {
    
    let articles: [Article]
    let store: GrasppStore
    
    var body: some View {
        VStack (alignment:.leading, spacing: 14) {
            // MARK: Section Header
            HStack (spacing: 16){
                Text("Favorites")
                    .font(.title2)
                    .fontWeight(.bold)
                
                NavigationLink(value: FavoriteDestination()) {
                    Image(systemName: "chevron.right")
                        .font(.title2)
                        .fontWeight(.bold)
                        .foregroundStyle(.secondary)
                }
                
                Spacer()
            }
            .padding(.horizontal, 16)
            
            // MARK: Section Content
            
            if articles.isEmpty {
                // MARK: Empty state
                Text("No favorites yet. Tap the star icon on any article")
                    .font(.subheadline)
                    .foregroundStyle(.secondary)
                    .padding(.horizontal, 16)
            } else {
                // MARK: Favorite articles
                // 2-column grid, max 4 items
                
                let visible = Array(articles.prefix(4))
                
                LazyVGrid (
                    columns: [GridItem(.flexible()), GridItem(.flexible())],
                    spacing: 12
                ) {
                    ForEach(visible) { article in
                        NavigationLink(value: article){
                            CardFavorite(
                                symbolName: article.category?.icon ?? "doc",
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

struct FavoriteDestination: Hashable {}

//#Preview {
//    FavoritesProgressive()
//}
