//
//  RecentlyViewedScreen.swift
//  graspp
//
//  Created by Nadia Putri Natali Lubis on 14/06/26.
//

import SwiftUI
import SwiftData

struct RecentlyViewedScreen: View {
    @Query private var allArticles: [Article]
    @StateObject private var store = GrasppStore.shared
    
    private var recentArticles: [Article] {
        store.recentIDs.compactMap { id in
            allArticles.first { $0.id == id }
        }
    }
    
    var body: some View {
        ScrollView {
            VStack(spacing: 12) {
                ForEach(recentArticles) { article in
                    NavigationLink(value: article) {
                        CardArticleCategory(article: article)
                    }
                    .buttonStyle(.plain)
                }
            }
            .padding(.horizontal, 16)
            .padding(.top, 8)
        }
        .background(Color(.systemGroupedBackground))
        .navigationTitle("Recently Viewed")
        .navigationBarTitleDisplayMode(.large)
    }
}

struct RecentlyViewedPreview: View {
    init() {
        setupPreviewStore()
    }
    
    var body: some View {
        NavigationStack {
            RecentlyViewedScreen()
                .modelContainer(previewContainer)
        }
    }
}

#Preview {
    RecentlyViewedPreview()
}
