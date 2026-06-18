//
//  Models.swift
//  graspp
//
//  Created by Nadia Putri Natali Lubis on 13/06/26.
//

import SwiftUI
import SwiftData
import Combine

// MARK: - Category

@Model
final class ArticleCategory {
    @Attribute(.unique) var id: UUID
    var name: String
    var icon: String          // SF Symbol name
    var colorName: String     // "indigp]o" | "pink" | "orange" | "yellow"
    var sortOrder: Int

    @Relationship(deleteRule: .cascade, inverse: \Article.category)
    var articles: [Article] = []

    init(
        id: UUID = UUID(),
        name: String,
        icon: String,
        colorName: String,
        sortOrder: Int
    ) {
        self.id = id
        self.name = name
        self.icon = icon
        self.colorName = colorName
        self.sortOrder = sortOrder
    }

    var color: Color {
        switch colorName {
        case "indigo": return .indigo
        case "pink":   return .pink
        case "orange": return .orange
        case "yellow": return .yellow
        default:       return .blue
        }
    }
}

// MARK: - Code Snippet

@Model
final class CodeSnippet {
    @Attribute(.unique) var id: UUID
    var language: String      // "SwiftUI" | "UIKit" | "Swift"
    var code: String          // raw code string
    var sortOrder: Int

    var article: Article?

    init(
        id: UUID = UUID(),
        language: String,
        code: String,
        sortOrder: Int = 0
    ) {
        self.id = id
        self.language = language
        self.code = code
        self.sortOrder = sortOrder
    }
}

// MARK: - Reference

@Model
final class ArticleReference {
    @Attribute(.unique) var id: UUID
    var title: String
    var url: String

    var article: Article?

    init(
        id: UUID = UUID(),
        title: String,
        url: String
    ) {
        self.id = id
        self.title = title
        self.url = url
    }
}

// MARK: - Article

@Model
final class Article {
    @Attribute(.unique) var id: UUID
    var title: String
//    var category: String
    var summary: String       // one-liner for list screen
    var body: String          // full markdown body
    var hig: String           // HIG quote, plain string
    var higSource: String     // e.g. "Apple HIG · Typography"
    var sortOrder: Int
    var createdAt: Date

    var category: ArticleCategory?

    @Relationship(deleteRule: .cascade, inverse: \CodeSnippet.article)
    var snippets: [CodeSnippet] = []

    @Relationship(deleteRule: .cascade, inverse: \ArticleReference.article)
    var references: [ArticleReference] = []

    init(
        id: UUID = UUID(),
        title: String,
        summary: String,
        body: String,
        hig: String = "",
        higSource: String = "",
        sortOrder: Int = 0,
        createdAt: Date = .now
    ) {
        self.id = id
        self.title = title
        self.summary = summary
        self.body = body
        self.hig = hig
        self.higSource = higSource
        self.sortOrder = sortOrder
        self.createdAt = createdAt
    }

    var sortedSnippets: [CodeSnippet] {
        snippets.sorted { $0.sortOrder < $1.sortOrder }
    }
}

// MARK: - UserDefaults Keys

enum GrasppDefaults {
    static let favoritesKey     = "graspp.favorites"
    static let recentlyViewedKey = "graspp.recentlyViewed"
    static let maxRecentCount   = 20
}

// MARK: - UserDefaultsManager

final class GrasppStore: ObservableObject {
    static let shared = GrasppStore()
    private init() {}

    // MARK: Favorites

    @Published private(set) var favoriteIDs: [UUID] = {
        let raw = UserDefaults.standard.stringArray(forKey: GrasppDefaults.favoritesKey) ?? []
        return raw.compactMap { UUID(uuidString: $0) }
    }()

    func isFavorite(_ article: Article) -> Bool {
        favoriteIDs.contains(article.id)
    }

    func toggleFavorite(_ article: Article) {
        if isFavorite(article) {
            favoriteIDs.removeAll { $0 == article.id }
        } else {
            favoriteIDs.append(article.id)
        }
        persist(favoriteIDs, key: GrasppDefaults.favoritesKey)
    }

    // MARK: Recently Viewed

    @Published private(set) var recentIDs: [UUID] = {
        let raw = UserDefaults.standard.stringArray(forKey: GrasppDefaults.recentlyViewedKey) ?? []
        return raw.compactMap { UUID(uuidString: $0) }
    }()

    func markViewed(_ article: Article) {
        recentIDs.removeAll { $0 == article.id }
        recentIDs.insert(article.id, at: 0)
        if recentIDs.count > GrasppDefaults.maxRecentCount {
            recentIDs = Array(recentIDs.prefix(GrasppDefaults.maxRecentCount))
        }
        persist(recentIDs, key: GrasppDefaults.recentlyViewedKey)
    }

    // MARK: Private

    private func persist(_ ids: [UUID], key: String) {
        UserDefaults.standard.set(ids.map(\.uuidString), forKey: key)
    }
}
