//
//  FavoriteScreen.swift
//  graspp
//
//  Created by Nadia Putri Natali Lubis on 14/06/26.
//

import SwiftUI
import SwiftData

struct FavoriteScreen: View {
    @Query private var allArticles: [Article]
    @StateObject private var store = GrasppStore.shared

    private var favoriteArticles: [Article] {
        store.favoriteIDs.compactMap { id in
            allArticles.first { $0.id == id }
        }
    }

    var body: some View {
        ScrollView {
            LazyVGrid(
                columns: [GridItem(.flexible()), GridItem(.flexible())],
                spacing: 12
            ) {
                ForEach(favoriteArticles) { article in
                    NavigationLink(value: article) {
                        CardFavorite(article: article)
                    }
                    .buttonStyle(.plain)
                }
            }
            .padding(.horizontal, 16)
            .padding(.top, 8)
        }
        .background(Color(.systemGroupedBackground))
        .navigationTitle("Favorite")
        .navigationBarTitleDisplayMode(.large)
    }
}

private struct FavoriteScreenPreview: View {
    init() {
        setupPreviewStore()
    }

    var body: some View {
        NavigationStack {
            FavoriteScreen()
        }
        .modelContainer(previewContainer)
    }
}

#Preview {
    FavoriteScreenPreview()
}
