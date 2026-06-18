//
//  FavoritesProgressive.swift
//  graspp
//
//  Created by Nadia Putri Natali Lubis on 13/06/26.
//

import SwiftUI
import SwiftData

struct FavoritesProgressive: View {
    
    let articles: [Article]
    
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
                        .foregroundColor(.secondary)
                }
                
                Spacer()
            }
            .padding(.horizontal, 16)
            
            // MARK: Section Content
            
            if articles.isEmpty {
                // MARK: Empty state
                EmptyContainer(symbol: "star.slash", headline: "No favorites yet.", subHeadline: "Tap the star icon on any article.")

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
                            CardFavorite(article: article)
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

struct FavoritesProgressivePreview: View {
    let isEmptyState: Bool
        private let modelContainer: ModelContainer
        
        init(isEmptyState: Bool = false) {
            self.isEmptyState = isEmptyState
            
            if isEmptyState {
                self.modelContainer = Self.makeEmptyPreviewContainer()
            } else {
                setupPreviewStore()
                self.modelContainer = previewContainer
            }
        }
        
        var body: some View {
            NavigationStack {
                FavoritesProgressive(articles: isEmptyState ? [] : sampleArticles)
                    .modelContainer(modelContainer)
            }
        }
        
        private static func makeEmptyPreviewContainer() -> ModelContainer {
            let schema = Schema([
                ArticleCategory.self,
                Article.self,
                CodeSnippet.self,
                ArticleReference.self
            ])
            let config = ModelConfiguration(isStoredInMemoryOnly: true)
            return try! ModelContainer(for: schema, configurations: config)
        }
}


// 1. Preview untuk State Normal (Ada Data)
#Preview("Default State") {
    FavoritesProgressivePreview(isEmptyState: false)
}

// 2. Preview untuk Empty State (Kosong)
#Preview("Empty State") {
    FavoritesProgressivePreview(isEmptyState: true)
}
