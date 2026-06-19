//
//  SearchScreen.swift
//  graspp
//
//  Created by Nadia Putri Natali Lubis on 15/06/26.
//

import SwiftUI
import SwiftData

struct SearchScreen: View {
    
    @Query private var allArticles: [Article]
    @StateObject private var store = GrasppStore.shared
    @State private var query = ""
    @State private var isSearching = false
    
    // Search history - last 10 search terms
    @AppStorage("graspp.searchHistory") private var historyRaw = ""
    
    var searchHistory: [String] {
        historyRaw.split(separator: "|").map(String.init)
    }
    
    var searchResults: [Article] {
        guard !query.trimmingCharacters(in: .whitespaces).isEmpty else { return []}
        let q = query.lowercased()
        
        return allArticles.filter {
            $0.title.lowercased().contains(q) ||
            $0.summary.lowercased().contains(q) ||
            ($0.category?.name.lowercased().contains(q) ?? false)
        }
    }
    
    var recentArticles: [Article] {
        store.recentIDs.compactMap { id in
            allArticles.first { $0.id == id}
        }
    }
    
    
    var body: some View {
        NavigationStack {
            ScrollView {
                VStack(alignment: .leading, spacing: 0) {
                    
                    // MARK: Typing - show results
                    if !query.isEmpty {
                        if searchResults.isEmpty {
                            VStack(spacing: 8) {
                                Image(systemName: "magnifyingglass")
                                    .font(.largeTitle)
                                    .foregroundStyle(.secondary)
                                Text("No results for \"\(query)\"")
                                    .font(.headline)
                                Text("Try a different keyword")
                                    .font(.subheadline)
                                    .foregroundStyle(.secondary)
                            }
                            .frame(maxWidth: .infinity)
                            .padding(40)
                        } else {
                            sectionHeader("Results")
                            VStack(spacing: 8) {
                                ForEach(searchResults) { article in
                                    NavigationLink(value: article) {
                                        CardArticleList(article: article, highlight: query)
                                    }
                                    .buttonStyle(.plain)
                                }
                            }
                            .padding(.horizontal, 16)
                            .padding(.top, 8)
                        }
                        
                        // MARK: Idle - show history then recent
                    } else {
                        if !searchHistory.isEmpty {
                            sectionHeader("Recent Search")
                            VStack (spacing: 0) {
                                ForEach(searchHistory, id: \.self) { term in
                                    Button {
                                        query = term
                                    } label: {
                                        HStack {
                                            Image(systemName: "clock")
                                                .font(.subheadline)
                                                .foregroundStyle(.secondary)
                                            Text(term)
                                                .font(.subheadline)
                                                .foregroundStyle(.primary)
                                            Spacer()
                                            Image(systemName: "arrow.up.left")
                                                .font(.caption)
                                                .foregroundStyle(.secondary)
                                        }
                                        .padding(.horizontal, 14)
                                        .padding(.vertical, 12)
                                    }
                                    Divider().padding(.leading, 44)
                                }
                            }
                            .background(Color(.secondarySystemGroupedBackground), in: RoundedRectangle(cornerRadius: 12))
                            .padding(.horizontal, 16)
                            
                            Button("Clear history") {
                                historyRaw = ""
                            }
                            .font(.subheadline)
                            .foregroundStyle(.red)
                            .padding(.top, 8)
                            .padding(.horizontal, 16)
                        }
                        
                        if !recentArticles.isEmpty {
                            sectionHeader("Recently Viewed")
                            VStack (spacing: 8) {
                                ForEach(Array(recentArticles.prefix(5))) { article in
                                    NavigationLink(value:article) {
                                        CardHistory(
                                            article: article
                                        )
                                    }
                                    .buttonStyle(.plain)
                                }
                            }
                            .padding(.horizontal, 16)
                            .padding(.top, 8)
                        }
                    }
                }
                .padding(.top, 8)
                .padding(.bottom, 24)
            }
            
            .navigationTitle("Search")
            .navigationBarTitleDisplayMode(.inline)
            .background(Color(.systemGroupedBackground))
            
            // MARK: Search
            .searchable(text: $query, placement: .toolbar, prompt: "Search")
            .autocorrectionDisabled()
            .onSubmit (of: .search){
                saveToHistory(query)
            }
            
            .navigationDestination(for: Article.self) { article in
                ArticleScreen(article: article)
            }
        }
    }
    
    // MARK: Helpers
    
    @ViewBuilder
    func sectionHeader(_ title: String) -> some View {
        Text(title.uppercased())
            .font(.caption)
            .fontWeight(.semibold)
            .foregroundStyle(.secondary)
            .kerning(0.5)
            .padding(.horizontal, 16)
            .padding(.top, 20)
            .padding(.bottom, 8)
    }
    
    func saveToHistory(_ term: String) {
        let trimmed = term.trimmingCharacters(in: .whitespaces)
        guard !trimmed.isEmpty else { return }
        var history = searchHistory.filter { $0 != trimmed }
        history.insert(trimmed, at: 0)
        history = Array(history.prefix(10))
        historyRaw = history.joined(separator: "|")
    }
}


struct SearchScreenPreview : View {
    init() {
        setupPreviewStore()
    }
    
    var body: some View {
        NavigationStack {
            SearchScreen()
                .modelContainer(previewContainer)
        }
    }
}

#Preview {
    SearchScreenPreview()
}

#Preview("Highlighted") {
    CardArticleList(article: sampleArticle, highlight: "how ios")
        .padding()
}
