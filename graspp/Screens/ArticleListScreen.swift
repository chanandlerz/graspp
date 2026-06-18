//
//  ArticleListScreen.swift
//  graspp
//
//  Created by Nadia Putri Natali Lubis on 15/06/26.
//

import SwiftUI
import SwiftData

struct ArticleListScreen: View {
    
    let category: ArticleCategory
    
    var body: some View {
        
        
        ScrollView {
            LazyVStack(spacing: 12) {
                ForEach(category.articles.sorted { $0.sortOrder < $1.sortOrder }) { article in
                    NavigationLink(value: article) {
                        CardArticleList(article: article)
                    }
                    .buttonStyle(.plain)
                }
            }
            .padding(.horizontal)
        }
        .navigationTitle(category.name)
        .navigationBarTitleDisplayMode(.large)
        .navigationDestination(for: Article.self) { article in
            ArticleScreen(article: article)
        }
    }
}


#Preview {
    NavigationStack {
        ArticleListScreen(category: sampleArticleListCategory)
    }
}
