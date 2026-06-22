//
//  HomeScreen.swift
//  graspp
//
//  Created by Nadia Putri Natali Lubis on 13/06/26.
//

import SwiftUI
import SwiftData

struct HomeScreen: View {
    @Query private var allArticles: [Article]
    @StateObject private var store = GrasppStore.shared
    
    var favoriteArticles: [Article] {
        store.favoriteIDs.compactMap { id in
            allArticles.first {$0.id == id}
        }
    }
    
    var recentArticles: [Article] {
        store.recentIDs.compactMap { id in
            allArticles.first {$0.id == id}
        }
    }
    
    var body: some View {
        NavigationStack {
            ScrollView {
                VStack (alignment: .leading, spacing: 28 ) {
                    FavoritesProgressive(articles: favoriteArticles)
                    
                    RecentlyViewedProgressive(
                        articles:recentArticles,
                    )
                }
                .padding(.top, 8)
            }
            
            .navigationTitle("My Shelf")
            .navigationBarTitleDisplayMode(.large)
            .background(Color(.systemGroupedBackground))
            
            // Navigate to article
            .navigationDestination(for: Article.self) { article in
                ArticleScreen(article: article)
            }
            
            // Navigate to full favorites screen
            .navigationDestination(for: FavoriteDestination.self) {_ in
                FavoriteScreen()
            }
            
            // Navigate to full recentlyViewed screen
            .navigationDestination(for: RecentlyViewedDestination.self) {_ in
                RecentlyViewedScreen()
            }
        }
    }
}


@MainActor
struct HomeScreenPreview: View {
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
            HomeScreen()
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
    HomeScreenPreview(isEmptyState: false)
}

// 2. Preview untuk Empty State (Kosong)
#Preview("Empty State") {
    HomeScreenPreview(isEmptyState: true)
}

