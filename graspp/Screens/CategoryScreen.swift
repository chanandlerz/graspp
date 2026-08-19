//
//  CategoryScreen.swift
//  graspp
//
//  Created by Nadia Putri Natali Lubis on 14/06/26.
//

import SwiftUI
import SwiftData

struct CategoryScreen: View {
    @Environment(\.dynamicTypeSize) var dynamicTypeSize
    
    var columns: [GridItem] {
        if dynamicTypeSize >= .accessibility1 {
            return [GridItem(.flexible())]
        } else {
            return [
                GridItem(.flexible(), spacing: 12),
                GridItem(.flexible(), spacing: 12)
            ]
        }
    }
    
    @Query(sort: \ArticleCategory.sortOrder) var categories: [ArticleCategory]
    
    var body: some View {
        NavigationStack {
            ScrollView {
                VStack(alignment: .leading, spacing: 0) {
                    LazyVGrid(columns: columns, spacing: 12) {
                        ForEach(categories) { category in
                            NavigationLink(value: category) {
                                CardCategory(category: category)
                            }
                            .buttonStyle(.plain)
                        }
                    }
                    .padding(.horizontal, 16)
                    .padding(.top, 16)
                    .padding(.bottom, 24)
                }
            }
            .background(Color(.systemGroupedBackground))
            .navigationTitle("Category")
            .navigationBarTitleDisplayMode(.large)
            .navigationDestination(for: ArticleCategory.self) { category in
                ArticleListScreen(category: category)
            }
        }
    }
}

#Preview {
    CategoryScreen()
        .modelContainer(previewContainer)
}
