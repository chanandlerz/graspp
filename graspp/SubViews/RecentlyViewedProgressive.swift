//
//  RecentlyViewedProgressive.swift
//  graspp
//
//  Created by Nadia Putri Natali Lubis on 14/06/26.
//

import SwiftUI
import SwiftData

struct RecentlyViewedProgressive: View {
    
    let articles: [Article]
    
    var body: some View {
        VStack (alignment: .leading, spacing: 14){
            // MARK: Section header
            HStack (spacing: 16){
                Text("Recently viewed")
                    .font(.title2)
                    .fontWeight(.bold)
                
                NavigationLink(value: RecentlyViewedDestination()) {
                    Image(systemName: "chevron.right")
                        .font(.title3)
                        .fontWeight(.semibold)
                        .foregroundColor(.secondary)
                }
                
                Spacer()
            }
            .padding(.horizontal, 16)
            
            if articles.isEmpty {
                EmptyContainer(symbol: "clock.badge.exclamationmark", headline: "Nothing viewed yet.", subHeadline: "Start exploring from Category or Search.")

            } else {
                // Max 5 items
                VStack(spacing: 8) {
                    ForEach(Array(articles.prefix(5))) { article in
                        NavigationLink(value: article) {
                            CardArticleCategory(
                                article: article                            )
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

struct RecentlyViewedProgressivePreview: View {
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
                RecentlyViewedProgressive(articles: isEmptyState ? [] : sampleArticles)
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
    RecentlyViewedProgressivePreview(isEmptyState: false)
}

// 2. Preview untuk Empty State (Kosong)
#Preview("Empty State") {
    RecentlyViewedProgressivePreview(isEmptyState: true)
}
