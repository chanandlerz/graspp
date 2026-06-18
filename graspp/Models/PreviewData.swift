//
//  PreviewData.swift
//  graspp
//
//  Created by Nadia Putri Natali Lubis on 17/06/26.
//

import Foundation
import SwiftUI
import SwiftData

// MARK: - Preview Container

/// ModelContainer khusus preview — in-memory, tidak disimpan ke disk
@MainActor
let previewContainer: ModelContainer = {
    let schema = Schema([
        ArticleCategory.self,
        Article.self,
        CodeSnippet.self,
        ArticleReference.self
    ])
    let config = ModelConfiguration(isStoredInMemoryOnly: true)
    let container = try! ModelContainer(for: schema, configurations: config)
    SeedData.insert(into: container.mainContext)
    return container
}()

// MARK: - Sample Data

/// Satu category untuk preview
@MainActor
var sampleCategory: ArticleCategory {
    let cat = ArticleCategory(
        name: "Typography",
        icon: "textformat",
        colorName: "purple",
        sortOrder: 0
    )

    let article = Article(
        title: "Dynamic Type",
        summary: "How iOS scales text based on user preference.",
        body: "Sample body",
        hig: "",
        higSource: ""
    )

    article.category = cat

    return cat
}

/// Satu article lengkap untuk preview
@MainActor
var sampleArticle: Article {
    let cat = ArticleCategory(
        name: "Typography",
        icon: "textformat",
        colorName: "purple",
        sortOrder: 0
    )
    let article = Article(
        title: "Dynamic Type",
        summary: "How iOS scales text based on user preference.",
        body: """
        Dynamic Type allows users to set their preferred text size via **Settings > Accessibility > Larger Text**.

        ## Rules

        - Always use text styles, never hardcode pt sizes
        - Never use fixed-height containers for text rows
        - Allow scrolling — never clip text that overflows
        """,
        hig: "Prefer the built-in text styles. When you use text styles, your text scales appropriately when the user changes the preferred text size in Settings.",
        higSource: "Apple HIG · Typography"
    )
    article.category = cat
    article.snippets = [
        CodeSnippet(language: "SwiftUI", code:
            """
            Text("Total Fat")
                .font(.body)

            Text("8g")
                .font(.headline)
            """,
            sortOrder: 0
        ),
        CodeSnippet(language: "UIKit", code:
            """
            label.font = UIFont.preferredFont(forTextStyle: .body)
            label.adjustsFontForContentSizeCategory = true
            """,
            sortOrder: 1
        )
    ]
    article.references = [
        ArticleReference(
            title: "Apple HIG · Typography",
            url: "https://developer.apple.com/design/human-interface-guidelines/typography"
        ),
        ArticleReference(
            title: "learnui.design iOS Guidelines",
            url: "https://www.learnui.design/blog/ios-design-guidelines-templates.html"
        )
    ]
    return article
}

/// Article tanpa HIG dan snippet — untuk test empty state
@MainActor
var sampleArticleMinimal: Article {
    let article = Article(
        title: "White Space",
        summary: "Intentional empty space that separates and organizes.",
        body: "White space is not wasted space. It is structure.",
        hig: "",
        higSource: ""
    )
    let cat = ArticleCategory(name: "Layout", icon: "rectangle.split.3x1", colorName: "orange", sortOrder: 2)
    article.category = cat
    return article
}

/// Array articles untuk preview list
@MainActor
var sampleArticles: [Article] {
    [sampleArticle, sampleArticleMinimal]
}
