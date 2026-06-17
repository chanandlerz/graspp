//
//  HomeScreen.swift
//  graspp
//
//  Created by Nadia Putri Natali Lubis on 13/06/26.
//

import SwiftUI
import SwiftData

struct HomeScreen: View {
    
    //    @Environment(\.modelContext) private var context
    //    @Query private var categories: [ArticleCategory]
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
                    FavoritesProgressive(
                        articles: favoriteArticles,
                        store: store
                    )
                    
                    RecentlyViewedProgressive(
                        articles:recentArticles,
                        store: store
                    )
                }
                .padding(.top, 8)
            }
            
            .navigationTitle("Graspp")
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

#Preview {
    HomeScreen()
}
