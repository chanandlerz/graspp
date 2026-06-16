//
//  SeedData.swift
//  graspp
//
//  Created by Nadia Putri Natali Lubis on 13/06/26.
//

import SwiftData
import Foundation

// MARK: - Seed

/// Call once on first launch from grasppApp.swift
/// Example:
///   if !UserDefaults.standard.bool(forKey: "graspp.seeded") {
///       SeedData.insert(into: context)
///       UserDefaults.standard.set(true, forKey: "graspp.seeded")
///   }

enum SeedData {
    static func insert(into context: ModelContext) {

        // MARK: Categories

        let typography = ArticleCategory(
            name: "Typography",
            icon: "textformat",
            colorName: "purple",
            sortOrder: 0
        )
        let spacing = ArticleCategory(
            name: "Spacing",
            icon: "ruler",
            colorName: "teal",
            sortOrder: 1
        )
        let layout = ArticleCategory(
            name: "Layout",
            icon: "rectangle.split.3x1",
            colorName: "orange",
            sortOrder: 2
        )
        let fundamentals = ArticleCategory(
            name: "Design Fundamentals",
            icon: "lightbulb",
            colorName: "blue",
            sortOrder: 3
        )

        [typography, spacing, layout, fundamentals].forEach { context.insert($0) }

        // MARK: Typography Articles

        let dynamicType = Article(
            title: "Dynamic Type",
            summary: "How iOS scales text based on user preference.",
            body: """
            Dynamic Type allows users to set their preferred text size system-wide via **Settings > Accessibility > Display & Text Size > Larger Text**. Apps that support it scale all text accordingly.

            **Size range:** xSmall (9pt Body) to AX5 (53pt Body). Default is Large (17pt Body).

            ## Rules

            - Always use text styles, never hardcode pt sizes
            - In UIKit, set `adjustsFontForContentSizeCategory = true` on every label
            - In SwiftUI, `.font(.body)` scales automatically — no extra step needed
            - Never use fixed-height containers for text rows — use `min-height`, not `height`
            - If a row has side-by-side label and value, stack them vertically at large sizes
            - Allow scrolling — never clip text that overflows
            """,
            hig: "Prefer the built-in text styles. When you use text styles, your text scales appropriately when the user changes the preferred text size in Settings.",
            higSource: "Apple HIG · Typography",
            sortOrder: 0
        )
        dynamicType.category = typography
        dynamicType.snippets = [
            CodeSnippet(language: "SwiftUI", code:
                """
                // Scales automatically with Dynamic Type
                Text("Total Fat")
                    .font(.body)

                Text("8g")
                    .font(.headline)
                """, sortOrder: 0),
            CodeSnippet(language: "UIKit", code:
                """
                // Must opt in manually
                label.font = UIFont.preferredFont(forTextStyle: .body)
                label.adjustsFontForContentSizeCategory = true
                label.numberOfLines = 0
                """, sortOrder: 1)
        ]
        dynamicType.references = [
            ArticleReference(title: "Apple HIG · Typography", url: "https://developer.apple.com/design/human-interface-guidelines/typography"),
            ArticleReference(title: "Design+Code iOS Handbook", url: "https://designcode.io/ios-design-handbook-typography-and-dynamic-type")
        ]

        let typeVsFont = Article(
            title: "Typeface vs Font",
            summary: "They are not the same thing.",
            body: """
            A common misconception — typeface and font are not interchangeable.

            **Typeface** is the design of the letterforms. It is what you *see*. Think of it as the visual identity of the type.

            **Font** is the digital file that delivers a typeface. It is what you *use*.

            > Analogy: a typeface is like a song. A font is the MP3 file.

            ## In iOS

            The system typeface is **SF Pro** (San Francisco). It has two optical sizes:

            - **SF Pro Text** — optimised for sizes 19pt and below
            - **SF Pro Display** — optimised for sizes 20pt and above

            iOS switches between them automatically when you use built-in text styles. You never need to pick manually.
            """,
            hig: "Use the built-in text styles whenever possible. The built-in text styles let you express content in ways that are visually distinct, while retaining optimal legibility.",
            higSource: "Apple HIG · Typography",
            sortOrder: 1
        )
        typeVsFont.category = typography
        typeVsFont.references = [
            ArticleReference(title: "typogui.de", url: "http://typogui.de")
        ]

        let textStyles = Article(
            title: "iOS Text Styles",
            summary: "The 11 built-in styles and when to use each.",
            body: """
            iOS provides 11 built-in text styles. Always use these — never hardcode font sizes. They work with Dynamic Type automatically.

            | Style | Default Size | Weight | Use for |
            |---|---|---|---|
            | Large Title | 34pt | Regular | Top-level screen title |
            | Title 1 | 28pt | Regular | Major section header |
            | Title 2 | 22pt | Regular | Sub-section header, modal title |
            | Title 3 | 20pt | Regular | Smaller header within content |
            | Headline | 17pt | Semibold | List item name, key label |
            | Body | 17pt | Regular | Default for all readable text |
            | Callout | 16pt | Regular | Supporting info below headline |
            | Subhead | 15pt | Regular | Section label, metadata |
            | Footnote | 13pt | Regular | Secondary info, timestamps |
            | Caption 1 | 12pt | Regular | Field labels, image captions |
            | Caption 2 | 11pt | Regular | Fine print, badge labels |

            ## Decision guide

            When in doubt, use **Body**. Use **Headline** for the most important single line in a row. Use **Caption 1** for labels that support, not lead.
            """,
            hig: "Consider using the built-in text styles. These styles are based on the system fonts and allow you to take advantage of key typographic features, such as Dynamic Type.",
            higSource: "Apple HIG · Typography",
            sortOrder: 2
        )
        textStyles.category = typography
        textStyles.snippets = [
            CodeSnippet(language: "SwiftUI", code:
                """
                Text("Calories")
                    .font(.headline)

                Text("150 kcal")
                    .font(.body)

                Text("Per 100g serving")
                    .font(.caption)
                    .foregroundStyle(.secondary)
                """, sortOrder: 0)
        ]
        textStyles.references = [
            ArticleReference(title: "Apple HIG · Typography", url: "https://developer.apple.com/design/human-interface-guidelines/typography"),
            ArticleReference(title: "learnui.design iOS Guidelines", url: "https://www.learnui.design/blog/ios-design-guidelines-templates.html")
        ]

        let typeHierarchy = Article(
            title: "Type Hierarchy",
            summary: "Control reading order through size, weight, and color.",
            body: """
            Type hierarchy controls where the eye travels and in what order. Achieved through **size**, **weight**, and **color** — not by mixing typefaces.

            ## The three levels

            Use a maximum of three levels on any single screen.

            1. **Primary** — highest contrast, largest or boldest. One dominant element per screen.
            2. **Secondary** — medium contrast, supporting information.
            3. **Tertiary** — lowest contrast, fine print, metadata.

            ## Rules

            - Size contrast must be meaningful — 17pt vs 19pt is not a hierarchy
            - Weight contrast works even at the same size — Regular vs Semibold is enough
            - Color: primary at 100% opacity, secondary at ~60%, tertiary at ~40%
            - Never use low contrast for important information

            ## Example

            ```
            Total Fat          Headline (semibold, primary)
            8g per serving     Body (regular, secondary)
            includes 1g sat.   Caption (regular, tertiary)
            ```
            """,
            hig: "Use font weight, size, and color to highlight the most important information in your app.",
            higSource: "Apple HIG · Typography",
            sortOrder: 3
        )
        typeHierarchy.category = typography
        typeHierarchy.references = [
            ArticleReference(title: "IxDF · Visual Hierarchy", url: "https://ixdf.org/literature/topics/visual-hierarchy"),
            ArticleReference(title: "UX Planet · Typography in UI", url: "https://uxplanet.org/principles-of-typography-in-ui-design-bc28f1f9666d")
        ]

        [dynamicType, typeVsFont, textStyles, typeHierarchy].forEach { context.insert($0) }

        // MARK: Spacing Articles

        let eightPtGrid = Article(
            title: "The 8pt Grid",
            summary: "All spacing should be a multiple of 8.",
            body: """
            All spacing in iOS UI should be a multiple of **8pt** — or 4pt for tight internal gaps. This is the underlying logic of all native iOS components.

            ## Why it works

            8pt divides cleanly into all iOS screen widths. It also aligns with the minimum tap target (44pt = 8 × 5.5), keeping layout and interaction consistent.

            ## Scale

            | Value | Common use |
            |---|---|
            | 4pt | Icon-to-label gap, badge padding |
            | 8pt | Gap between stacked labels |
            | 12pt | Tight internal card padding |
            | 16pt | Standard row padding, content margin |
            | 24pt | Card internal padding, section gap |
            | 32pt | Gap between major sections |
            | 44pt | Minimum tap target |

            When a value does not land on the grid, round to the nearest multiple of 4.
            """,
            hig: "Give tappable elements a hit target of at least 44x44 points.",
            higSource: "Apple HIG · Layout",
            sortOrder: 0
        )
        eightPtGrid.category = spacing

        let padding = Article(
            title: "Padding",
            summary: "Space inside a container, between its border and its content.",
            body: """
            **Padding** is the space inside a container, between its boundary and its content. It defines how much room content has to breathe within its wrapper.

            ## iOS standard values

            | Component | Padding |
            |---|---|
            | Screen content (horizontal) | 16pt from edge |
            | Card internal | 16–24pt |
            | List row (vertical) | 11–12pt top and bottom |
            | Button (horizontal) | 16–20pt |
            | Button (vertical) | 8–12pt |

            ## Padding vs Margin

            - **Padding** = space *inside* a container
            - **Margin** = space *outside* a component, between it and the next element

            In SwiftUI, both are handled with `.padding()` — applied before or after a background to produce different results.
            """,
            hig: "Give content and controls enough space so your interface looks balanced and people can comfortably interact with it.",
            higSource: "Apple HIG · Layout",
            sortOrder: 1
        )
        padding.category = spacing
        padding.snippets = [
            CodeSnippet(language: "SwiftUI", code:
                """
                // All sides
                Text("Hello")
                    .padding(16)

                // Per edge
                Text("Hello")
                    .padding(.horizontal, 16)
                    .padding(.vertical, 12)

                // Padding before background = inside the card
                Text("Hello")
                    .padding(16)
                    .background(.background.secondary, in: RoundedRectangle(cornerRadius: 12))
                """, sortOrder: 0)
        ]

        let safeArea = Article(
            title: "Safe Area",
            summary: "The region not obscured by Dynamic Island, home indicator, or corners.",
            body: """
            The safe area is the region of the screen not covered by hardware features — Dynamic Island, home indicator, or rounded corners.

            Always lay out content inside the safe area. Backgrounds can extend beyond it.

            ## Approximate insets (iPhone 16 Pro)

            | Area | Inset |
            |---|---|
            | Top (Dynamic Island) | ~54pt |
            | Bottom (home indicator) | ~34pt |
            | Sides | 0pt |

            ## Rule

            Content must never be clipped by hardware. Backgrounds extending edge-to-edge are fine and expected.
            """,
            hig: "Don't mask or cut off content by placing it outside the safe area of the display.",
            higSource: "Apple HIG · Layout",
            sortOrder: 2
        )
        safeArea.category = spacing
        safeArea.snippets = [
            CodeSnippet(language: "SwiftUI", code:
                """
                // SwiftUI respects safe area by default — no action needed

                // Extend background behind safe area only
                Color.blue
                    .ignoresSafeArea()

                // Content stays inside safe area (default behaviour)
                VStack {
                    Text("Safe content")
                }
                """, sortOrder: 0)
        ]

        [eightPtGrid, padding, safeArea].forEach { context.insert($0) }

        // MARK: Layout Articles

        let whatIsLayout = Article(
            title: "What is Layout?",
            summary: "Organizing elements so the user knows what matters and what to do.",
            body: """
            Layout is the deliberate organization of elements on screen so the user instantly knows:

            1. What is most important
            2. What belongs together
            3. What to do next

            Layout is not decoration — it is structure. Good layout is invisible. The user reads the content, not the arrangement.

            ## Five goals

            **Visual hierarchy** — the most important element catches the eye first. Everything else follows by weight.

            **Grouping** — related elements are close. Unrelated elements are apart. Proximity communicates relationship.

            **Alignment** — everything aligns to an invisible grid. Misalignment is felt even when the user cannot name it.

            **Consistency** — the same type of element receives the same spacing and treatment across the entire app.

            **Breathing room** — white space separates groups, rests the eye, and signals where sections end.
            """,
            hig: "Align text, images, and buttons in a way that makes the layout easy to scan and reveals the underlying structure.",
            higSource: "Apple HIG · Layout",
            sortOrder: 0
        )
        whatIsLayout.category = layout

        let visualHierarchy = Article(
            title: "Visual Hierarchy",
            summary: "Control where the eye goes and in what order.",
            body: """
            Visual hierarchy controls where the eye travels and in what order. It is achieved through **size**, **weight**, **color**, and **contrast** — not by using different typefaces.

            ## The tools

            **Size contrast** — a meaningful size difference creates a clear hierarchy. Title at 28pt vs body at 17pt reads as hierarchy. Title at 19pt vs body at 17pt reads as flat.

            **Weight contrast** — Semibold draws the eye even at the same size as Regular. Use weight to emphasize names, values, and key numbers.

            **Color and opacity** — primary text at 100% opacity, secondary at ~60%, tertiary at ~40%. Never use low contrast for important information.

            ## The rule

            Maximum three levels of hierarchy on one screen. If you need a fourth level, the grouping is wrong — not the typography.

            ## The anchor

            Every screen needs one dominant element that anchors the eye first. A screen with five equally weighted elements has no hierarchy.
            """,
            hig: "Use font weight, size, and color to highlight the most important information and help people understand the structure of your content.",
            higSource: "Apple HIG · Typography",
            sortOrder: 1
        )
        visualHierarchy.category = layout

        let whiteSpace = Article(
            title: "White Space",
            summary: "Intentional empty space that separates, organizes, and rests the eye.",
            body: """
            White space — also called negative space — is intentional empty space around and between elements. It is not wasted space. It is structure.

            ## Three jobs

            **Separates groups** — more space signals unrelated. Less space signals related. You do not need divider lines if spacing is intentional.

            **Creates hierarchy** — the most important element often has the most space around it. Surrounding space draws attention inward.

            **Rests the eye** — dense layouts are cognitively tiring. Generous spacing makes reading effortless.

            ## The premium signal

            More padding feels more considered and premium. Native iOS apps — Settings, Health, App Store — are all very generous with spacing. When in doubt, add more.

            ## Consistency

            All cards on a screen should use the same internal padding. Mixing 12pt and 20pt padding in the same screen looks accidental, not intentional.
            """,
            hig: "White space helps people understand the grouping and hierarchy of your content, and makes your interface easier to scan.",
            higSource: "Apple HIG · Layout",
            sortOrder: 2
        )
        whiteSpace.category = layout

        let whenToCard = Article(
            title: "When to Use a Card",
            summary: "Cards are for self-contained, bounded objects — not everything.",
            body: """
            A card is a container with a visible background that groups related content into a bounded unit.

            ## Use a card when

            - Content is a self-contained, tappable unit — a product tile, a contact record, a receipt
            - Mixed content types need grouping — text alongside an icon alongside a button
            - The item needs to stand out from the page background
            - The entire unit is interactive — tapping anywhere opens it

            ## Skip the card when

            - It is a long list of identical rows — use separators instead
            - Content is full-width and spans the screen
            - The component already sits on a card background — a card inside a card adds noise without meaning
            - It is simple label and value pairs in a table

            ## iOS pattern

            The standard for grouped lists in iOS is sections with rounded cards and plain rows inside. This is exactly what Settings, Contacts, and Reminders use.
            """,
            hig: "Use grouped lists to display information in sections. Each section can have a header and a footer to provide context.",
            higSource: "Apple HIG · Lists and Tables",
            sortOrder: 3
        )
        whenToCard.category = layout
        whenToCard.snippets = [
            CodeSnippet(language: "SwiftUI", code:
                """
                // Card container
                VStack(alignment: .leading, spacing: 8) {
                    Text("Nutrition Facts")
                        .font(.title2)
                        .bold()
                    Text("per 100g")
                        .font(.subheadline)
                        .foregroundStyle(.secondary)
                }
                .padding(16)
                .background(.background.secondary, in: RoundedRectangle(cornerRadius: 12))

                // Grouped list (automatic card styling)
                List {
                    Section("Typography") {
                        Text("Dynamic Type")
                        Text("Text Styles")
                    }
                }
                .listStyle(.insetGrouped)
                """, sortOrder: 0)
        ]

        [whatIsLayout, visualHierarchy, whiteSpace, whenToCard].forEach { context.insert($0) }

        // MARK: Design Fundamentals Articles

        let gestalt = Article(
            title: "Gestalt Principles",
            summary: "How the brain automatically groups visual elements.",
            body: """
            Gestalt principles describe how the human brain perceives and groups visual information automatically. Understanding them explains why certain layouts feel structured and others feel chaotic.

            ## The principles most relevant to UI

            **Proximity** — elements close together are perceived as a group. This is the most important principle for layout. You can remove divider lines entirely if spacing alone communicates the grouping.

            **Similarity** — elements that look alike are perceived as related. The basis for consistent styling — same colour, same weight, same shape means same type of thing.

            **Continuity** — the eye follows lines and curves naturally. The basis for alignment grids. Elements on the same invisible line feel connected.

            **Figure and ground** — the brain distinguishes objects from their backgrounds. The basis for cards, modals, and overlays.

            **Closure** — the brain completes incomplete shapes. A rounded rectangle does not need a border to read as a container if the background colour provides enough contrast.

            ## In practice

            Apple uses these constantly. Many iOS list rows have no explicit separator — just consistent spacing. The grouping reads clearly because proximity does the work.
            """,
            hig: "Use visual grouping to help people understand the relationships between the elements in your app.",
            higSource: "Apple HIG · Visual Design",
            sortOrder: 0
        )
        gestalt.category = fundamentals

        let contrast = Article(
            title: "Contrast",
            summary: "The ratio between text and background luminance. Required for accessibility.",
            body: """
            Contrast ratio measures the difference in luminance between a text colour and its background. It determines whether text is readable for all users, including those with low vision.

            ## WCAG requirements

            **AA (minimum — required for Apple's Sufficient Contrast label):**
            - Normal text (below 18pt regular or 14pt bold): **4.5:1**
            - Large text (18pt+ regular or 14pt+ bold): **3:1**
            - UI components and icons: **3:1**

            **AAA (ideal):**
            - Normal text: **7:1**
            - Large text: **4.5:1**

            ## Why semantic tokens matter

            Hardcoded hex values like `#333333` might produce 12:1 contrast in light mode but only 1.5:1 in dark mode. Semantic tokens like `.label` and `.secondaryLabel` adapt automatically.

            When a user enables **Increase Contrast** in Accessibility settings, semantic tokens boost automatically. Hardcoded colours do not respond.

            ## Semantic color tokens

            | Token | Use |
            |---|---|
            | `.label` | Primary text — always highest contrast |
            | `.secondaryLabel` | Supporting text, captions |
            | `.tertiaryLabel` | Placeholder, hints |
            | `.quaternaryLabel` | Decorative only — not for readable content |
            """,
            hig: "To make your text as legible as possible, make sure the text and background colors have sufficient contrast. High contrast between text and its background helps everyone, but especially people who have low vision.",
            higSource: "Apple HIG · Accessibility · Color and Effects",
            sortOrder: 1
        )
        contrast.category = fundamentals
        contrast.snippets = [
            CodeSnippet(language: "SwiftUI", code:
                """
                // Always use semantic tokens, never hardcode hex
                Text("Primary content")
                    .foregroundStyle(.primary)         // = .label

                Text("Supporting detail")
                    .foregroundStyle(.secondary)       // = .secondaryLabel

                Text("Hint or placeholder")
                    .foregroundStyle(.tertiary)        // = .tertiaryLabel
                """, sortOrder: 0)
        ]
        contrast.references = [
            ArticleReference(title: "Apple HIG · Accessibility", url: "https://developer.apple.com/design/human-interface-guidelines/accessibility"),
            ArticleReference(title: "WCAG 2.1 · Contrast", url: "https://www.w3.org/TR/WCAG21/#contrast-minimum")
        ]

        let designOverview = Article(
            title: "Design Fundamentals Overview",
            summary: "The eight core principles behind all visual design decisions.",
            body: """
            These principles underpin every visual design decision, regardless of platform or medium. iOS adds specific values and conventions for each — but the principles themselves are universal.

            ## The eight principles

            **Visual hierarchy** — guide the eye to what matters most. Every screen needs one dominant element.

            **Alignment** — create invisible structure and order. Everything aligns to a grid, even if the grid is not visible.

            **Proximity** — group related elements, separate unrelated ones. Space communicates relationship.

            **Repetition and consistency** — the same type of element is treated the same way throughout the app.

            **Contrast** — create emphasis and differentiation through size, weight, and colour differences.

            **White space** — breathe, separate, and organize. More space reads as more considered.

            **Color** — convey meaning, not just decoration. Use system semantic colours wherever possible.

            **Typography** — make content readable and hierarchical. One typeface, multiple weights, correct text styles.

            ## The order of operations

            Start with structure (alignment, proximity, repetition), then layer in contrast and hierarchy (size, weight, colour), then refine with white space and typography. Decoration comes last — if at all.
            """,
            hig: "Design apps that work for everyone. Consider how your app will be used across different contexts, capabilities, and preferences.",
            higSource: "Apple HIG · Foundations",
            sortOrder: 2
        )
        designOverview.category = fundamentals

        [gestalt, contrast, designOverview].forEach { context.insert($0) }
    }
}
