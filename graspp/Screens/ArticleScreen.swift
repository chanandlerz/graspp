//
//  ArticleScreen.swift
//  graspp
//
//  Created by Nadia Putri Natali Lubis on 15/06/26.
//

import SwiftUI
import MarkdownUI

// MARK: - Section anchor for floating pill
enum ArticleSection: String, CaseIterable {
    case info = "Info"
    case hig = "HIG"
    case code = "Code"
    case ref = "Ref"
}


struct ArticleScreen: View {
    
    let article: Article
    
    @StateObject private var store = GrasppStore.shared
    @State private var activeSection: ArticleSection = .info
    
    var availableSections: [ArticleSection] {
        var sections : [ArticleSection] = [.info]
        if !article.hig.isEmpty { sections.append(.hig) }
        if !article.sortedSnippets.isEmpty { sections.append(.code) }
        if !article.references.isEmpty { sections.append(.ref) }
        return sections
    }
    
    var body: some View {
        ZStack(alignment: .bottom) {
            ScrollViewReader {
                proxy in
                ScrollView{
                    VStack(alignment: .leading, spacing: 0) {
                        
                        // MARK: Header
                        VStack(alignment: .leading, spacing: 6) {
                            // Category badge
                            if let category = article.category {
                                HStack(spacing: 6) {
                                    Circle()
                                        .fill(category.color)
                                        .frame(width: 6, height: 6)
                                    Text(category.name)
                                        .font(.caption)
                                        .fontWeight(.medium)
                                        .foregroundStyle(category.color)
                                }
                                .padding(.horizontal, 10)
                                .padding(.vertical, 4)
                                .background(category.color.opacity(0.12), in: Capsule())
                            }
                            
                            Text(article.title)
                                .font(.title)
                                .fontWeight(.bold)
                                .fixedSize(horizontal: false, vertical: true)
                        }
                        .padding(.horizontal, 16)
                        .padding(.top, 8)
                        .padding(.bottom, 20)
                        //                        .background(.red)
                        
                        
                        // MARK: Info Section
                        VStack(alignment: .leading,spacing: 0) {
                            SectionLabel(icon: "doc.text", title: "Info")
                                .id(ArticleSection.info)
                                .padding(.horizontal, 16)
                                .padding(.bottom, 12)
                            
                            Markdown(article.body)
                                .markdownTheme(.graspp)
                                .padding(.horizontal, 16)
                        }
                        
                        // MARK: HIG Section
                        if !article.hig.isEmpty {
                            sectionDivider
                            
                            VStack(alignment: .leading, spacing: 12) {
                                SectionLabel(icon: "apple.logo", title: "HIG")
                                    .id(ArticleSection.hig)
                                
                                HIGBlock(quote: article.hig, source: article.higSource, color: article.category?.color ?? .blue
                                )
                            }
                            .padding(.horizontal, 16)
                        }
                        
                        // MARK: - Code Section
                        if !article.sortedSnippets.isEmpty {
                            sectionDivider
                            
                            VStack(alignment: .leading, spacing: 12) {
                                SectionLabel(icon: "chevron.left.forwardslash.chevron.right", title: "Code")
                                    .id(ArticleSection.code)
                                
                                ForEach(article.sortedSnippets) { snippet in
                                    CodeBlock(snippet: snippet)
                                }
                            }
                            .padding(.horizontal, 16)
                        }
                        
                        // MARK: - References Section
                        if !article.references.isEmpty {
                            sectionDivider
                            
                            VStack(alignment: .leading, spacing: 12) {
                                SectionLabel(icon: "link", title: "References")
                                    .id(ArticleSection.ref)
                                
                                ReferenceList (references: article.references)
                            }
                            .padding(.horizontal, 16)
                        }
                        
                        // Bottom padding
                        Color.clear.frame(height: 80)
                    }
                }
                
                // MARK: - Floating Pill scroll handler
                .overlay(alignment: .bottom) {
                    FloatingPill(active: $activeSection, availableSections: availableSections) { section in
                        withAnimation {
                            proxy.scrollTo(section, anchor: .top)
                        }
                        activeSection = section
                    }
                    .padding(.bottom, 16)
                }
            }
        }
        
        .navigationBarTitleDisplayMode(.inline)
        .toolbar {
            ToolbarItem(placement: .topBarTrailing) {
                Button {
                    store.toggleFavorite(article)
                } label: {
                    Image(systemName: store.isFavorite(article) ? "star.fill" : "star")
                }
            }
        }
        .onAppear {
            store.markViewed(article)
        }
        //        .background(Color(.systemGroupedBackground))
        .background(Color(.systemBackground))
    }
    
    private var sectionDivider: some View {
        Divider()
            .padding(.horizontal, 16)
            .padding(.vertical, 20)
    }
}



// MARK: - Section Label

struct SectionLabel: View {
    let icon: String
    let title: String
    
    var body: some View {
        HStack(spacing: 6) {
            Image(systemName: icon)
                .font(.caption)
                .foregroundStyle(.secondary)
            
            Text(title.uppercased())
                .font(.caption)
                .fontWeight(.semibold)
                .foregroundStyle(.secondary)
                .kerning(0.5)
        }
    }
}


// MARK: - HIG Block

struct HIGBlock: View {
    let quote: String
    let source: String
    let color: Color
    
    var body: some View{
        HStack(spacing: 0) {
            // Left accent border
            RoundedRectangle(cornerRadius: 2)
                .fill(color)
                .frame(width: 8)
            
            VStack(alignment: .leading, spacing: 6) {
                Text(quote)
                    .font(.subheadline)
                    .italic()
                    .fixedSize(horizontal: false, vertical: true)
                
                Text(source)
                    .font(.caption)
                    .foregroundStyle(.secondary)
            }
            .padding(.horizontal, 14)
            .padding(.vertical, 12)
            
            Spacer(minLength: 0)
        }
        .background(Color(.systemGray6), in: RoundedRectangle(cornerRadius: 10))
    }
}


// MARK: - Code Block
struct CodeBlock: View {
    let snippet: CodeSnippet
    @State private var copied = false
    
    private var lines: [String] {
        snippet.code.components(separatedBy: "\n")
    }
    
    var body: some View {
        VStack(alignment: .leading, spacing: 0) {
            // Header
            HStack {
                Text(snippet.language.uppercased())
                    .font(.caption2)
                    .fontWeight(.medium)
                    .foregroundStyle(Color(.systemGray))
                    .kerning(0.5)
                
                Spacer()
                
                Button {
                    UIPasteboard.general.string = snippet.code
                    copied = true
                    DispatchQueue.main.asyncAfter(deadline: .now() + 1.5) { copied = false }
                } label: {
                    HStack(spacing: 4) {
                        Image(systemName: copied ? "checkmark" : "doc.on.doc").font(.caption)
                        Text(copied ? "Copied" : "Copy").font(.caption)
                    }
                    .foregroundStyle(.secondary)
                }
            }
            .padding(.horizontal, 14)
            .padding(.vertical, 10)
            
            Divider().opacity(0.15)
            
            
            
            // Code body — line numbers pinned, code scrolls
            HStack(alignment: .top, spacing: 2) {
                // Pinned line numbers
                VStack(alignment: .trailing, spacing: 2) {
                    ForEach(Array(lines.enumerated()), id: \.offset) { i, _ in
                        Text("\(i + 1)")
                            .font(.system(.footnote, design: .monospaced))
                            .foregroundStyle(Color(.systemGray))
                    }
                }
                .padding(.vertical, 14)
                .padding(.horizontal, 10)
                .background(Color(red: 0.10, green: 0.10, blue: 0.11))                .padding(.vertical, 14)
                .padding(.horizontal, 10)
                .background(Color(red: 0.10, green: 0.10, blue: 0.11))
                
                Divider().opacity(0.15)
                
                // Scrollable code
                ScrollView(.horizontal, showsIndicators: false) {
                    VStack(alignment: .leading, spacing: 2) { // match spacing
                        ForEach(Array(lines.enumerated()), id: \.offset) { _, line in
                            Text(line.isEmpty ? " " : line)
                                .font(.system(.footnote, design: .monospaced))
                                .foregroundStyle(Color(red: 0.85, green: 0.85, blue: 0.85))
                        }
                    }
                    .padding(.vertical, 14)
                    .padding(.horizontal, 14)
                }
            }
        }
        .background(Color(red: 0.12, green: 0.12, blue: 0.13), in: RoundedRectangle(cornerRadius: 10))
    }
}


struct CodeBlock_old: View {
    let snippet: CodeSnippet
    @State private var copied = false
    
    var body: some View {
        
        VStack(alignment: .leading, spacing: 0) {
            // Header
            HStack {
                Text(snippet.language.uppercased())
                    .font(.caption2)
                    .fontWeight(.medium)
                    .foregroundStyle(.secondary)
                    .kerning(0.5)
                
                Spacer()
                
                Button {
                    UIPasteboard.general.string = snippet.code
                    copied = true
                    DispatchQueue.main.asyncAfter(deadline: .now() + 1.5) {
                        copied = false
                    }
                } label: {
                    HStack(spacing: 4) {
                        Image(systemName: copied ? "checkmark" : "doc.on.doc")
                            .font(.caption)
                        Text(copied ? "Copied" : "Copy")
                            .font(.caption)
                    }
                    .foregroundStyle(.secondary)
                }
            }
            .padding(.horizontal, 14)
            .padding(.vertical, 10)
            
            Divider()
                .background(Color.white.opacity(0.08))
            
            // Code body
            ScrollView(.horizontal, showsIndicators: false) {
                Text(snippet.code)
                    .font(.system(.footnote, design: .monospaced))
                    .foregroundStyle(Color(.label))
                    .padding(14)
                    .frame(maxWidth: .infinity, alignment: .leading)
            }
        }
        .background(Color(.systemGray6), in: RoundedRectangle(cornerRadius: 10))
    }
}


// MARK: - Reference List

struct ReferenceList: View {
    let references: [ArticleReference]
    
    var body: some View{
        VStack(spacing: 0) {
            ForEach(Array(references.enumerated()), id:\.element.id) {
                index, ref in
                if let url = URL(string: ref.url) {
                    Link(destination: url){
                        HStack {
                            Text(ref.title)
                                .font(.subheadline)
                                .foregroundStyle(.blue)
                                .frame(maxWidth: .infinity, alignment: .leading)
                            
                            Image(systemName: "arrow.up.right")
                                .font(.caption)
                                .foregroundStyle(.secondary)
                        }
                        .padding(.horizontal, 14)
                        .padding(.vertical, 12)
                    }
                }
                
                if index < references.count - 1 {
                    Divider()
                        .padding(.leading, 14)
                }
            }
        }
        .background(Color(.secondarySystemGroupedBackground), in:RoundedRectangle(cornerRadius: 10))
    }
}


// MARK: - FLoating Pill

struct FloatingPill: View {
    @Binding var active: ArticleSection
    let availableSections: [ArticleSection]
    let onTap: (ArticleSection) -> Void
    
    var body: some View {
        HStack(spacing: 2) {
            ForEach(availableSections, id:\.self) { section in
                Button {
                    onTap(section)
                } label: {
                    Text(section.rawValue)
                        .font(.subheadline)
                        .fontWeight(.medium)
                        .padding(.horizontal, 14)
                        .padding(.vertical, 8)
                        .background(
                            active == section
                            ? Color(.label)
                            : Color.clear,
                            in: Capsule()
                        )
                        .foregroundStyle(
                            active == section
                            ? Color(.systemBackground)
                            : Color(.secondaryLabel)
                        )
                }
            }
        }
        .padding(4)
        .background(.regularMaterial, in: Capsule())
        .shadow(color: .black.opacity(0.08), radius: 8, y:4)
    }
}



// MARK: - Preview
#Preview ("Full Article") {
    NavigationStack {
        ArticleScreen(article: sampleArticle)
    }
}

#Preview ("Simple Article") {
    NavigationStack {
        ArticleScreen(article: sampleArticleMinimal)
    }
}
