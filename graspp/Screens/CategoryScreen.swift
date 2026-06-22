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
            return [GridItem(.flexible()), GridItem(.flexible())]
        }
    }
    
    @Query(sort: \ArticleCategory.sortOrder) var categories: [ArticleCategory]
    
    var body: some View {
        
        NavigationStack {
            ScrollView {
                LazyVGrid(columns: columns, spacing: 12) {
                    ForEach(categories) {category in
                        NavigationLink(value: category) {
                            CardCategory(category: category)
                        }
                        
                    }
                }
                .padding(.horizontal, 16)
            }
            .padding(.top, 16)
            .background(Color(.systemGroupedBackground))
            .listStyle(.plain)
            .navigationTitle("Category")
            .navigationBarTitleDisplayMode(.large)
            .navigationDestination(for: ArticleCategory.self) { category in ArticleListScreen(category: category)
            }
            
        }
    }
}
#Preview {
    CategoryScreen()
        .modelContainer(previewContainer)
}
