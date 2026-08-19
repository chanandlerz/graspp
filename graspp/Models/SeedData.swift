//
//  SeedData.swift
//  graspp
//
//  Created by Nadia Putri Natali Lubis on 13/06/26.
//

import SwiftData
import Foundation

// MARK: - Seed Data Setup

/// Call once on first launch from grasppApp.swift
/// Example:
///   if !UserDefaults.standard.bool(forKey: "graspp.seeded") {
///       SeedData.insert(into: context)
///       UserDefaults.standard.set(true, forKey: "graspp.seeded")
///   }

enum SeedData {
    static func insert(into context: ModelContext) {
        
        // MARK: - Categories
        
        let typography = ArticleCategory(
            name: "Typography",
            icon: "textformat",
            colorName: "indigo",
            sortOrder: 0
        )
        let spacing = ArticleCategory(
            name: "Spacing",
            icon: "ruler",
            colorName: "orange",
            sortOrder: 1
        )
        let layout = ArticleCategory(
            name: "Layout",
            icon: "rectangle.split.3x1",
            colorName: "pink",
            sortOrder: 2
        )
        let fundamentals = ArticleCategory(
            name: "Design Fundamentals",
            icon: "lightbulb",
            colorName: "yellow",
            sortOrder: 3
        )
        let colorsMaterials = ArticleCategory(
            name: "Colors & Materials",
            icon: "paintpalette",
            colorName: "purple",
            sortOrder: 4
        )
        let navigationSheets = ArticleCategory(
            name: "Navigation & Modals",
            icon: "arrow.triangle.turn.up.right.diamond",
            colorName: "teal",
            sortOrder: 5
        )
        let swiftui = ArticleCategory(
            name: "SwiftUI Patterns",
            icon: "chevron.left.slash.chevron.right",
            colorName: "mint",
            sortOrder: 6
        )
        let accessibility = ArticleCategory(
            name: "Accessibility",
            icon: "figure.stand",
            colorName: "blue",
            sortOrder: 7
        )
        
        [typography, spacing, layout, fundamentals, colorsMaterials, navigationSheets, swiftui, accessibility].forEach { context.insert($0) }
        
        // MARK: - Typography Articles
        
        let dynamicType = Article(
            title: "Dynamic Type Support",
            summary: "Making your app readable at any text size.",
            body: """
# Dynamic Type Support

Dynamic Type allows users to set their preferred text size system-wide via **Settings > Accessibility > Display & Text Size > Larger Text**. Apps that support it scale all text accordingly.

**Size range:** `xSmall` (9pt Body) to `AX5` (53pt Body). Default is `Large` (17pt Body).

## Why it matters

Not all users see the same. Some prefer larger text for comfort, others have vision requirements. Supporting Dynamic Type ensures your app works for everyone without broken layouts.

## Core rules

- Always use semantic text styles, never hardcode pt sizes.
- In UIKit, set `adjustsFontForContentSizeCategory = true` on every label.
- In SwiftUI, `.font(.body)` scales automatically — no extra step needed.
- Never use fixed-height containers for text rows — use `minHeight`, not fixed `height`.
- If a row has side-by-side label and value, stack them vertically at large sizes using `ViewThatFits`.
- Allow scrolling — never clip text that overflows.

## Quick Implementation

```swift
// SwiftUI auto-scaling text
Text("Account Balance")
    .font(.subheadline)
    .foregroundStyle(.secondary)

Text("$1,240.50")
    .font(.title2)
    .fontWeight(.bold)
```

## Testing

- **On device:** `Settings > Accessibility > Display & Text Size > Larger Text`
- **On simulator:** `Cmd + Shift + A` in Simulator, then enable "Larger Accessibility Sizes".

Test at **at least** `.accessibility1` (`AX1`) and `.accessibility5` (`AX5`) to catch layout breaks.
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
    .fontWeight(.semibold)
""", sortOrder: 0),
            CodeSnippet(language: "UIKit", code:
"""
// Must opt in manually
label.font = UIFont.preferredFont(forTextStyle: .body)
label.adjustsFontForContentSizeCategory = true
label.numberOfLines = 0
""", sortOrder: 1),
            CodeSnippet(language: "SwiftUI", code:
"""
// Test at multiple Dynamic Type sizes in preview
#Preview {
    ForEach(DynamicTypeSize.allCases, id: \\.self) { size in
        Text("Dynamic Type Test")
            .font(.body)
            .environment(\\.dynamicTypeSize, size)
            .padding()
    }
}
""", sortOrder: 2)
        ]
        dynamicType.references = [
            ArticleReference(title: "Apple HIG · Typography", url: "[https://developer.apple.com/design/human-interface-guidelines/typography](https://developer.apple.com/design/human-interface-guidelines/typography)"),
            ArticleReference(title: "Apple HIG · Accessibility", url: "[https://developer.apple.com/design/human-interface-guidelines/accessibility](https://developer.apple.com/design/human-interface-guidelines/accessibility)")
        ]
        
        let typeVsFont = Article(
            title: "Typeface vs Font",
            summary: "They are not the same thing.",
            body: """
# Typeface vs Font

A common misconception — typeface and font are not interchangeable.

- **Typeface** is the design of the letterforms. It is what you *see*. Think of it as the visual identity of the type. Examples: `San Francisco`, `New York`, `Helvetica`, `Georgia`.
- **Font** is the digital file that delivers a typeface. It is what you *use*. A "font file" delivers a typeface to your screen.

> **Analogy:** A typeface is like a song. A font is the MP3 file.

## In iOS

The system typeface is **SF Pro** (San Francisco). It has two optical sizes:

- **SF Pro Text** — optimized for sizes 19pt and below (wider tracking, larger x-height).
- **SF Pro Display** — optimized for sizes 20pt and above (tighter tracking, higher contrast).

iOS switches between them automatically when you use built-in text styles. You never need to pick manually.

## When to use custom fonts

Custom fonts should be rare. They break accessibility and internationalization when scaled improperly. The only valid reason is brand identity. Even then, use custom fonts sparingly and never for dense body text.

## Loading custom fonts

If you must use a custom font, register it in `Info.plist` under "Fonts provided by application":

```xml
<key>UIAppFonts</key>
<array>
    <string>CustomBrand-Bold.otf</string>
</array>
```

Then scale it dynamically in SwiftUI:

```swift
Text("Brand Header")
    .font(.custom("CustomBrand-Bold", size: 24, relativeTo: .title2))
```
""",
            hig: "Use the San Francisco font family whenever possible. San Francisco is designed specifically for iOS and provides optimal legibility at any size.",
            higSource: "Apple HIG · Typography",
            sortOrder: 1
        )
        typeVsFont.category = typography
        typeVsFont.references = [
            ArticleReference(title: "SF Pro Font · Apple", url: "[https://developer.apple.com/fonts/](https://developer.apple.com/fonts/)"),
            ArticleReference(title: "typogui.de", url: "[http://typogui.de](http://typogui.de)")
        ]
        
        let textStyles = Article(
            title: "iOS Text Styles",
            summary: "The 11 built-in styles and when to use each.",
            body: """
# iOS Text Styles

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

When in doubt, use **Body**. Use **Headline** for the most important single line in a row. Use **Caption 1** for labels that support, not lead. Never use Caption 2 for readable content — it becomes unreadable at accessibility sizes.

## In SwiftUI

Use `.font()` modifier:

```swift
Text("Title").font(.title2)
Text("Body").font(.body)
Text("Fine print").font(.caption)
```

All of these respond to Dynamic Type automatically. No extra setup needed.
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
""", sortOrder: 0),
            CodeSnippet(language: "SwiftUI", code:
"""
// Wrong: hardcoded size, no Dynamic Type support
Text("Title").font(.system(size: 28))

// Right: semantic style, scales with Dynamic Type
Text("Title").font(.title2)
""", sortOrder: 1)
        ]
        textStyles.references = [
            ArticleReference(title: "Apple HIG · Typography", url: "[https://developer.apple.com/design/human-interface-guidelines/typography](https://developer.apple.com/design/human-interface-guidelines/typography)"),
            ArticleReference(title: "learnui.design iOS Guidelines", url: "[https://www.learnui.design/blog/ios-design-guidelines-templates.html](https://www.learnui.design/blog/ios-design-guidelines-templates.html)")
        ]
        
        let typeHierarchy = Article(
            title: "Type Hierarchy",
            summary: "Control reading order through size, weight, and color.",
            body: """
# Type Hierarchy

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
- Hierarchy emerges from the combination of size + weight + color, not from any single attribute

## Example structure

```
Total Fat           Headline (semibold 17pt, primary)
8g per serving      Body (regular 17pt, secondary @60%)
includes 1g sat.    Caption (regular 12pt, tertiary @40%)
```

## Common mistake

Creating four or five levels of text hierarchy. If you need more than three levels, the information architecture is wrong — not the typography.
""",
            hig: "Use font weight, size, and color to highlight the most important information in your app.",
            higSource: "Apple HIG · Typography",
            sortOrder: 3
        )
        typeHierarchy.category = typography
        typeHierarchy.snippets = [
            CodeSnippet(language: "SwiftUI", code:
"""
VStack(alignment: .leading, spacing: 4) {
    Text("Total Fat")
        .font(.headline)
        .fontWeight(.semibold)
    
    Text("8g per serving")
        .font(.body)
        .foregroundStyle(.secondary)
    
    Text("includes 1g saturated fat")
        .font(.caption)
        .foregroundStyle(.tertiary)
}
""", sortOrder: 0)
        ]
        typeHierarchy.references = [
            ArticleReference(title: "IxDF · Visual Hierarchy", url: "[https://ixdf.org/literature/topics/visual-hierarchy](https://ixdf.org/literature/topics/visual-hierarchy)"),
            ArticleReference(title: "UX Planet · Typography in UI", url: "[https://uxplanet.org/principles-of-typography-in-ui-design-bc28f1f9666d](https://uxplanet.org/principles-of-typography-in-ui-design-bc28f1f9666d)")
        ]
        
        let legibility = Article(
            title: "Legibility & Readability",
            summary: "Making text easy to read and understand.",
            body: """
# Legibility & Readability

**Legibility** = can you read the individual letterforms? (font size, contrast, spacing)
**Readability** = can you read the paragraph without effort? (line length, line height, tracking)

Both matter. Good typography is both legible and readable.

## Line height

Tight line height (1.0) = feels dense and formal.
Relaxed line height (1.5+) = feels spacious and readable.

iOS body text uses ~1.3 line height. Use `.relativeLineSpacing(.em(0.25))` in MarkdownUI to add breathing room.

## Line length

Optimal line length for body text: 45–75 characters. Longer lines are hard to scan. Shorter lines feel cramped.

On iPhone, natural line length is ~50 chars at 17pt body text. This is built in — do not fight it.

## Letter spacing

Tighter letter spacing (tracking) improves readability for body text. Looser letter spacing looks more upscale but reads slower.

## Paragraph spacing

Separate paragraphs with space, not with a line break. Space below paragraph = relationship to next paragraph.

Paragraph spacing = 1.5× line height (roughly).
""",
            hig: "Use the built-in text styles for optimal legibility and readability. They are tuned for iOS screen sizes and typical viewing distances.",
            higSource: "Apple HIG · Typography",
            sortOrder: 4
        )
        legibility.category = typography
        legibility.references = [
            ArticleReference(title: "Apple HIG · Typography", url: "[https://developer.apple.com/design/human-interface-guidelines/typography](https://developer.apple.com/design/human-interface-guidelines/typography)")
        ]
        
        [dynamicType, typeVsFont, textStyles, typeHierarchy, legibility].forEach { context.insert($0) }
        
        // MARK: - Spacing Articles
        
        let eightPtGrid = Article(
            title: "The 8pt Grid",
            summary: "All spacing should be a multiple of 8.",
            body: """
# The 8pt Grid

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
| 56pt | Large button or control |
| 64pt | Maximum padding on iPhone screen edge |

When a value does not land on the grid, round to the nearest multiple of 4.

## Testing your spacing

Use the 8pt grid in Sketch/Figma as a guide. When measuring in code, log the values — if they're not multiples of 4 or 8, something is wrong.

## Exception: micro-interactions

Within a single component (icon + text, for example), 2pt or 3pt gaps are acceptable if they improve visual balance. But all major spacing should follow the grid.
""",
            hig: "Give tappable elements a hit target of at least 44x44 points.",
            higSource: "Apple HIG · Layout",
            sortOrder: 0
        )
        eightPtGrid.category = spacing
        eightPtGrid.references = [
            ArticleReference(title: "Apple HIG · Layout", url: "[https://developer.apple.com/design/human-interface-guidelines/layout](https://developer.apple.com/design/human-interface-guidelines/layout)")
        ]
        
        let padding = Article(
            title: "Padding",
            summary: "Space inside a container, between its border and its content.",
            body: """
# Padding

**Padding** is the space inside a container, between its boundary and its content. It defines how much room content has to breathe within its wrapper.

## iOS standard values

| Component | Padding |
|---|---|
| Screen content (horizontal) | 16pt from edge |
| Card internal | 16–24pt |
| List row (vertical) | 11–12pt top and bottom |
| Button (horizontal) | 16–20pt |
| Button (vertical) | 8–12pt |
| Section header/footer | 16pt horizontal |

## Padding vs Margin

- **Padding** = space *inside* a container
- **Margin** = space *outside* a component, between it and the next element

In SwiftUI, both are handled with `.padding()` — applied before or after a background to produce different results.

## In SwiftUI

```swift
// Padding before background = inside the card
Text("Hello")
    .padding(16)
    .background(.background.secondary)

// Padding after background = outside (margin)
Text("Hello")
    .background(.background.secondary)
    .padding(16)
```

## Consistency

All cards on a screen should use the same padding. If one card is 16pt and another is 24pt, the inconsistency reads as error, not intentional variation.
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
""", sortOrder: 0),
            CodeSnippet(language: "SwiftUI", code:
"""
// Common pattern: card with consistent padding
VStack(alignment: .leading, spacing: 8) {
    Text("Nutrition Facts")
        .font(.headline)
    Text("per 100g")
        .font(.caption)
        .foregroundStyle(.secondary)
}
.frame(maxWidth: .infinity, alignment: .leading)
.padding(16)
.background(.background.secondary, in: RoundedRectangle(cornerRadius: 12))
""", sortOrder: 1)
        ]
        padding.references = [
            ArticleReference(title: "Apple HIG · Layout", url: "[https://developer.apple.com/design/human-interface-guidelines/layout](https://developer.apple.com/design/human-interface-guidelines/layout)")
        ]
        
        let safeArea = Article(
            title: "Safe Area & Insets",
            summary: "The region not obscured by hardware or system UI.",
            body: """
# Safe Area & Insets

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

## In SwiftUI

SwiftUI respects the safe area by default — no extra setup needed for standard content.

To extend a background behind safe area only:

```swift
Color.blue
    .ignoresSafeArea()

// But keep content inside
VStack {
    Text("Safe content")
}
```

## Bottom inset for keyboard

When a text field has focus, the keyboard covers ~50% of the screen. Use `ScrollViewReader` or `.ignoresSafeArea(edges: .bottom)` to keep content visible.
""",
            hig: "Don't mask or cut off content by placing it outside the safe area of the display.",
            higSource: "Apple HIG · Layout",
            sortOrder: 2
        )
        safeArea.category = spacing
        safeArea.snippets = [
            CodeSnippet(language: "SwiftUI", code:
"""
// Standard: content inside safe area, background outside
VStack {
    Text("Title")
        .font(.title2)
    Spacer()
}
.frame(maxWidth: .infinity, maxHeight: .infinity)
.background(.blue)
.ignoresSafeArea()  // extends background only
""", sortOrder: 0)
        ]
        safeArea.references = [
            ArticleReference(title: "Apple HIG · Layout", url: "[https://developer.apple.com/design/human-interface-guidelines/layout](https://developer.apple.com/design/human-interface-guidelines/layout)")
        ]
        
        let whiteSpace = Article(
            title: "White Space",
            summary: "Intentional empty space that separates, organizes, and rests the eye.",
            body: """
# White Space

White space — also called negative space — is intentional empty space around and between elements. It is not wasted space. It is structure.

## Three jobs

**Separates groups** — more space signals unrelated. Less space signals related. You do not need divider lines if spacing is intentional.

**Creates hierarchy** — the most important element often has the most space around it. Surrounding space draws attention inward.

**Rests the eye** — dense layouts are cognitively tiring. Generous spacing makes reading effortless.

## The premium signal

More padding feels more considered and premium. Native iOS apps — Settings, Health, App Store — are all very generous with spacing. When in doubt, add more.

## Consistency

All cards on a screen should use the same internal padding. Mixing 12pt and 20pt padding in the same screen looks accidental, not intentional.

## Testing

If your layout feels "busy" or "overwhelming", the problem is usually insufficient white space, not too much content.

Try adding 8pt to every padding value — if it feels better, it was the issue.
""",
            hig: "White space helps people understand the grouping and hierarchy of your content, and makes your interface easier to scan.",
            higSource: "Apple HIG · Layout",
            sortOrder: 3
        )
        whiteSpace.category = spacing
        whiteSpace.references = [
            ArticleReference(title: "Apple HIG · Layout", url: "[https://developer.apple.com/design/human-interface-guidelines/layout](https://developer.apple.com/design/human-interface-guidelines/layout)")
        ]
        
        [eightPtGrid, padding, safeArea, whiteSpace].forEach { context.insert($0) }
        
        // MARK: - Layout Articles
        
        let whatIsLayout = Article(
            title: "What is Layout?",
            summary: "Organizing elements so the user knows what matters and what to do.",
            body: """
# What is Layout?

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

## The invisible grid

Every iOS screen uses an 8pt invisible grid. All elements snap to it. Text baselines, icons, padding, spacing — all multiples of 4 or 8.

When a layout feels "off" without obvious reason, it is usually because an element is off-grid by 1 or 2 pixels.
""",
            hig: "Align text, images, and buttons in a way that makes the layout easy to scan and reveals the underlying structure.",
            higSource: "Apple HIG · Layout",
            sortOrder: 0
        )
        whatIsLayout.category = layout
        whatIsLayout.references = [
            ArticleReference(title: "Apple HIG · Layout", url: "[https://developer.apple.com/design/human-interface-guidelines/layout](https://developer.apple.com/design/human-interface-guidelines/layout)")
        ]
        
        let visualHierarchy = Article(
            title: "Visual Hierarchy",
            summary: "Control where the eye goes and in what order.",
            body: """
# Visual Hierarchy

Visual hierarchy controls where the eye travels and in what order. It is achieved through **size**, **weight**, **color**, and **contrast** — not by using different typefaces.

## The tools

**Size contrast** — a meaningful size difference creates a clear hierarchy. Title at 28pt vs body at 17pt reads as hierarchy. Title at 19pt vs body at 17pt reads as flat.

**Weight contrast** — Semibold draws the eye even at the same size as Regular. Use weight to emphasize names, values, and key numbers.

**Color and opacity** — primary text at 100% opacity, secondary at ~60%, tertiary at ~40%. Never use low contrast for important information.

**Position** — elements at the top-left are scanned first. Place important elements here (in LTR languages).

## The rule

Maximum three levels of hierarchy on one screen. If you need a fourth level, the grouping is wrong — not the typography.

## The anchor

Every screen needs one dominant element that anchors the eye first. A screen with five equally weighted elements has no hierarchy.

## In practice

Settings app: Each setting row has one dominant label (Headline), one secondary value (Body), and optional secondary text (Caption). That is three levels, consistently applied.
""",
            hig: "Use font weight, size, and color to highlight the most important information and help people understand the structure of your content.",
            higSource: "Apple HIG · Typography",
            sortOrder: 1
        )
        visualHierarchy.category = layout
        visualHierarchy.snippets = [
            CodeSnippet(language: "SwiftUI", code:
"""
// Three-level hierarchy
VStack(alignment: .leading, spacing: 4) {
    Text("Protein")  // Level 1: Headline
        .font(.headline)
        .fontWeight(.semibold)
    
    Text("25g")  // Level 2: Body
        .font(.body)
    
    Text("per serving")  // Level 3: Caption
        .font(.caption)
        .foregroundStyle(.secondary)
}
""", sortOrder: 0)
        ]
        visualHierarchy.references = [
            ArticleReference(title: "Apple HIG · Typography", url: "[https://developer.apple.com/design/human-interface-guidelines/typography](https://developer.apple.com/design/human-interface-guidelines/typography)")
        ]
        
        let whenToCard = Article(
            title: "Cards vs Lists",
            summary: "Choosing the right container pattern.",
            body: """
# Cards vs Lists

Two fundamental patterns for presenting grouped content. Knowing when to use each is crucial.

## Cards

**Use when:** Content is self-contained, image-heavy, or deserves visual emphasis.

Pros: Scannable, emphasizes individuality, flexible spacing, tactile feel.
Cons: Takes more vertical space, harder for long lists.

Characteristics:
- Bounded unit with visible background
- Usually tappable as a whole
- Often contains mixed content types (image + text + button)
- Good for feeds, product tiles, recipe cards

## Lists

**Use when:** Dense information, lots of rows, users need to compare.

Pros: Space-efficient, great for quick scanning, standard iOS pattern.
Cons: Less visual emphasis per item, harder to highlight one item.

Characteristics:
- Unbounded rows with dividers or spacing
- Often individual rows are tappable
- Consistent structure across all rows
- Good for settings, contacts, search results

## Hybrid approach

Use cards when screen space is ample. Switch to list at larger Dynamic Type sizes or small screens to maintain usability.

## iOS examples

- Mail: Uses list (compact, lots of emails)
- App Store: Uses cards (visual emphasis on apps)
- Settings: Uses list with grouped sections
- Reminders: Uses cards for projects, list for tasks within
""",
            hig: "Use grouped lists to display information in sections. Use cards for self-contained, tappable units.",
            higSource: "Apple HIG · Lists and Tables",
            sortOrder: 2
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
        whenToCard.references = [
            ArticleReference(title: "Apple HIG · Lists and Tables", url: "[https://developer.apple.com/design/human-interface-guidelines/lists-and-tables](https://developer.apple.com/design/human-interface-guidelines/lists-and-tables)")
        ]
        
        let gridVsStack = Article(
            title: "Grid Layout Decisions",
            summary: "When to use 1, 2, or 3 columns.",
            body: """
# Grid Layout Decisions

Grid layout (multiple columns) requires careful decisions about how many columns, when to switch, and how to handle content.

## Single column (1)

**Use:** Lists, text-heavy content, mobile-first design.
Pros: Easy to scan, no complex wrapping.
Cons: Takes vertical space.

iPhone portrait: Always single column for standard content.

## Two columns (2)

**Use:** Image galleries, category browsing, iPad.
Pros: Better use of space, visual interest.
Cons: Cards become smaller, text truncates.

iPhone landscape: Often switches to 2 columns for collections.
iPad: Default 2 columns for most content.

## Three or more columns

**Use:** Very wide screens (iPad Pro) or dense grids (emoji picker).
Pros: Maximum space utilization.
Cons: Cards too small for meaningful content.

Rule: If you need 3+ columns, consider a horizontal scroll instead.

## Switching based on Dynamic Type

At larger text sizes (`.accessibility1` and up), switch from 2 columns to 1. Larger text makes cards too small at 2 columns.

## Implementation

Test at all screen sizes AND all Dynamic Type sizes. A layout that works at normal text on iPhone may break at large text.
""",
            hig: "Adjust your layout based on available space and user preferences.",
            higSource: "Apple HIG · Layout",
            sortOrder: 3
        )
        gridVsStack.category = layout
        gridVsStack.snippets = [
            CodeSnippet(language: "SwiftUI", code:
"""
@Environment(\\.dynamicTypeSize) var dynamicTypeSize

var columns: [GridItem] {
    if dynamicTypeSize >= .accessibility1 {
        // Large text: single column
        return [GridItem(.flexible())]
    } else {
        // Normal text: two columns
        return [
            GridItem(.flexible()),
            GridItem(.flexible())
        ]
    }
}

var body: some View {
    LazyVGrid(columns: columns, spacing: 16) {
        ForEach(items) { item in
            ItemCard(item: item)
        }
    }
}
""", sortOrder: 0)
        ]
        gridVsStack.references = [
            ArticleReference(title: "Apple HIG · Layout", url: "[https://developer.apple.com/design/human-interface-guidelines/layout](https://developer.apple.com/design/human-interface-guidelines/layout)")
        ]
        
        [whatIsLayout, visualHierarchy, whenToCard, gridVsStack].forEach { context.insert($0) }
        
        
        // MARK: - Design Fundamentals Articles
        
        let gestalt = Article(
            title: "Gestalt Principles",
            summary: "How the brain automatically groups visual elements.",
            body: """
        # Gestalt Principles
        
        Gestalt principles describe how the human brain perceives and groups visual information automatically. Understanding them explains why certain layouts feel structured and others feel chaotic.
        
        ## The principles most relevant to UI
        
        **Proximity** — elements close together are perceived as a group. This is the most important principle for layout. You can remove divider lines entirely if spacing alone communicates the grouping.
        
        **Similarity** — elements that look alike are perceived as related. The basis for consistent styling — same colour, same weight, same shape means same type of thing.
        
        **Continuity** — the eye follows lines and curves naturally. The basis for alignment grids. Elements on the same invisible line feel connected.
        
        **Figure and ground** — the brain distinguishes objects from their backgrounds. The basis for cards, modals, and overlays.
        
        **Closure** — the brain completes incomplete shapes. A rounded rectangle does not need a border to read as a container if the background colour provides enough contrast.
        
        ## In practice
        
        Apple uses these constantly. Many iOS list rows have no explicit separator — just consistent spacing. The grouping reads clearly because proximity does the work.
        
        Settings app is a masterclass in Gestalt principles: proximity groups settings, similarity makes sections clear, and the repeated visual pattern (chevron at right) signals all rows are navigable.
        """,
            hig: "Use visual grouping to help people understand the relationships between the elements in your app.",
            higSource: "Apple HIG · Visual Design",
            sortOrder: 0
        )
        gestalt.category = fundamentals
        gestalt.references = [
            ArticleReference(title: "Apple HIG · Visual Design", url: "[https://developer.apple.com/design/human-interface-guidelines/visual-design](https://developer.apple.com/design/human-interface-guidelines/visual-design)")
        ]
        
        let contrast = Article(
            title: "Contrast & Sufficient Color",
            summary: "The ratio between text and background luminance. Required for accessibility.",
            body: """
        # Contrast & Sufficient Color
        
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
        
        ## Testing
        
        Use Accessibility Inspector on device:
        `Settings > Accessibility > Display & Text Size > Increase Contrast`
        
        Then verify all text remains readable. If it doesn't, your hardcoded colors are the problem.
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
        
        // For custom colors, create semantic tokens in Asset catalog
        Color(red: 0.2, green: 0.8, blue: 1.0)  // BAD: fixed contrast
        Color.accentColor                        // GOOD: adapts to environment
        """, sortOrder: 0)
        ]
        contrast.references = [
            ArticleReference(title: "Apple HIG · Accessibility", url: "[https://developer.apple.com/design/human-interface-guidelines/accessibility](https://developer.apple.com/design/human-interface-guidelines/accessibility)"),
            ArticleReference(title: "WCAG 2.2 · Contrast Standards", url: "[https://www.w3.org/TR/WCAG22/](https://www.w3.org/TR/WCAG22/)")
        ]
        
        let designOverview = Article(
            title: "Design Principles Overview",
            summary: "The eight core principles behind all visual design decisions.",
            body: """
        # Design Principles Overview
        
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
        
        ## Testing your design
        
        Show your design to someone who has never used an iOS app. Can they instantly identify:
        - What the screen is about?
        - What to do next?
        - Which elements are related?
        
        If not, your hierarchy or grouping needs work.
        """,
            hig: "Design apps that work for everyone. Consider how your app will be used across different contexts, capabilities, and preferences.",
            higSource: "Apple HIG · Foundations",
            sortOrder: 2
        )
        designOverview.category = fundamentals
        designOverview.references = [
            ArticleReference(title: "Apple HIG · Foundations", url: "[https://developer.apple.com/design/human-interface-guidelines/foundations](https://developer.apple.com/design/human-interface-guidelines/foundations)")
        ]
        
        let consistency = Article(
            title: "Consistency & Patterns",
            summary: "Building trust through predictability.",
            body: """
        # Consistency & Patterns
        
        Users learn your app's patterns in the first 30 seconds. Break them, and they're lost.
        
        ## Three types of consistency
        
        **Visual** — Same button style = same action type. Same spacing = same type of section.
        
        **Interaction** — Swipe-to-delete on all lists or none. Long-press always brings up context menu.
        
        **Conceptual** — "Add" button means add to this list. Back arrow means go up one level.
        
        ## When to break patterns
        
        Only for exceptional situations. Label clearly. Test with users.
        
        ## Apple's consistency
        
        iOS apps feel familiar because they follow the same patterns. That is by design.
        
        ## Pattern library
        
        Document your patterns. Share with your team. Update as you iterate.
        
        ## Common patterns
        
        - **Navigation**: Back button always top-left. Tab bar at bottom. Breadcrumb for hierarchy.
        - **Actions**: Primary action on the right (buttons). Destructive actions in red.
        - **Forms**: Labels above fields. Placeholder text inside fields. Validation on blur.
        - **Loading**: Skeleton screens or activity spinner. Never silent loading.
        """,
            hig: "Use consistent design patterns throughout your app to help users learn your interface quickly.",
            higSource: "Apple HIG · Visual Design",
            sortOrder: 3
        )
        consistency.category = fundamentals
        consistency.references = [
            ArticleReference(title: "Apple HIG · Visual Design", url: "[https://developer.apple.com/design/human-interface-guidelines/visual-design](https://developer.apple.com/design/human-interface-guidelines/visual-design)")
        ]
        
        [gestalt, contrast, designOverview, consistency].forEach { context.insert($0) }
        
        // MARK: - Colors & Materials Articles (NEW CATEGORY)
        
        let materialsAndVibrancy = Article(
            title: "Materials & Vibrancy",
            summary: "Layering blurred backgrounds and translucent materials for depth.",
            body: """
        # Materials & Vibrancy
        
        iOS uses blurred translucent materials to establish visual depth and context without occluding underlying views completely.
        
        ## Material Hierarchy
        
        | Material | Thickness | Use Case |
        |---|---|---|
        | `.ultraThinMaterial` | Minimal blur | Floating pills, subtle overlays |
        | `.thinMaterial` | Light blur | Navigation bars, toolbars |
        | `.regularMaterial` | Standard blur | Cards, modal sheets, floating panels |
        | `.thickMaterial` | Heavy blur | High-contrast overlays, popovers |
        | `.ultraThickMaterial` | Maximum blur | Full-screen backdrops |
        
        ## In SwiftUI
        
        ```swift
        HStack {
            Text("Floating Control")
        }
        .padding()
        .background(.ultraThinMaterial, in: Capsule())
        .shadow(color: .black.opacity(0.1), radius: 8, y: 4)
        ```
        """,
            hig: "Use materials to create a sense of depth and hierarchy, letting background colors softly show through.",
            higSource: "Apple HIG · Materials",
            sortOrder: 0
        )
        materialsAndVibrancy.category = colorsMaterials
        materialsAndVibrancy.snippets = [
            CodeSnippet(language: "SwiftUI", code:
        """
        VStack(spacing: 8) {
            Text("Frosted Glass Card")
                .font(.headline)
            Text("Adapts automatically across Light & Dark appearances.")
                .font(.subheadline)
                .foregroundStyle(.secondary)
        }
        .padding(16)
        .background(.regularMaterial, in: RoundedRectangle(cornerRadius: 16))
        """, sortOrder: 0)
        ]
        materialsAndVibrancy.references = [
            ArticleReference(title: "Apple HIG · Materials", url: "[https://developer.apple.com/design/human-interface-guidelines/materials](https://developer.apple.com/design/human-interface-guidelines/materials)")
        ]
        
        let semanticColors = Article(
            title: "System Semantic Colors",
            summary: "Dynamic system fills, grouped backgrounds, and tint states.",
            body: """
        # System Semantic Colors
        
        Semantic colors decouple visual design from fixed values, automatically adapting to Dark Mode, High Contrast, and system tints.
        
        ## Background Levels
        
        - `Color(.systemBackground)`: Base screen canvas.
        - `Color(.secondarySystemBackground)`: Grouped sections / card backgrounds on base canvas.
        - `Color(.tertiarySystemBackground)`: Nested cards or secondary tiles inside grouped sections.
        
        ## Grouped Variants
        
        - `Color(.systemGroupedBackground)`: Slate/neutral tint for multi-card table structures.
        - `Color(.secondarySystemGroupedBackground)`: Pure white in Light Mode, dark grey in Dark Mode for cards.
        """,
            hig: "Use semantic colors so your interface adapts gracefully to changes in appearance mode.",
            higSource: "Apple HIG · Color",
            sortOrder: 1
        )
        semanticColors.category = colorsMaterials
        semanticColors.references = [
            ArticleReference(title: "Apple HIG · Color", url: "[https://developer.apple.com/design/human-interface-guidelines/color](https://developer.apple.com/design/human-interface-guidelines/color)")
        ]
        
        [materialsAndVibrancy, semanticColors].forEach { context.insert($0) }
        
        // MARK: - Navigation & Modals Articles (NEW CATEGORY)
        
        let navigationStackPatterns = Article(
            title: "Modern NavigationStack & Paths",
            summary: "Data-driven navigation routing with NavigationPath and value destination matching.",
            body: """
        # NavigationStack & Value Routing
        
        Avoid legacy `NavigationLink(destination:)`. Modern SwiftUI uses value-based `NavigationLink(value:)` paired with `.navigationDestination(for:)`.
        
        ## Why Data-Driven Navigation Matters
        
        1. **Deep Linking:** Easily serialize and deserialize routes.
        2. **Programmatic Reset:** Reset paths back to root with `path.removeLast(path.count)`.
        3. **Decoupled Views:** View definitions are cleanly separated from parent hierarchy.
        
        ## Implementation Pattern
        
        ```swift
        @State private var path = NavigationPath()
        
        var body: some View {
            NavigationStack(path: $path) {
                List {
                    NavigationLink("Open Detail", value: ArticleDestination.detail(articleId))
                }
                .navigationDestination(for: ArticleDestination.self) { destination in
                    switch destination {
                    case .detail(let id):
                        ArticleDetailView(id: id)
                    }
                }
            }
        }
        ```
        """,
            hig: "Provide clear paths for navigation, allowing users to retrace their steps effortlessly.",
            higSource: "Apple HIG · Navigation",
            sortOrder: 0
        )
        navigationStackPatterns.category = navigationSheets
        navigationStackPatterns.snippets = [
            CodeSnippet(language: "SwiftUI", code:
        """
        enum AppRoute: Hashable {
            case article(UUID)
            case settings
        }
        
        struct RootNavView: View {
            @State private var navPath = NavigationPath()
        
            var body: some View {
                NavigationStack(path: $navPath) {
                    HomeFeedView()
                        .navigationDestination(for: AppRoute.self) { route in
                            switch route {
                            case .article(let id): ArticleDetailView(id: id)
                            case .settings: SettingsView()
                            }
                        }
                }
            }
        }
        """, sortOrder: 0)
        ]
        navigationStackPatterns.references = [
            ArticleReference(title: "Apple HIG · Navigation", url: "[https://developer.apple.com/design/human-interface-guidelines/navigation](https://developer.apple.com/design/human-interface-guidelines/navigation)"),
            ArticleReference(title: "SwiftUI NavigationStack Documentation", url: "[https://developer.apple.com/documentation/swiftui/navigationstack](https://developer.apple.com/documentation/swiftui/navigationstack)")
        ]
        
        let sheetDetents = Article(
            title: "Modal Sheets & Presentation Detents",
            summary: "Bottom sheet sizing, half-modal expansion, and background interactions.",
            body: """
        # Presentation Detents
        
        Sheets present secondary workflows without abandoning context. Configure interactive detents using `.presentationDetents`.
        
        ## Detent Options
        
        - `.medium`: Covers roughly 50% of the screen (ideal for picker tools and quick filters).
        - `.large`: Covers near 100% (ideal for full form completion).
        - `.fraction(0.35)`: Custom proportion for compact interactive trays.
        
        ## Background Interaction
        
        Allow users to tap underlying UI while the bottom sheet remains visible:
        
        ```swift
        .presentationBackgroundInteraction(.enabled(upThrough: .medium))
        ```
        """,
            hig: "Use sheets for self-contained tasks or quick contextual actions that don't require full screen replacement.",
            higSource: "Apple HIG · Sheets",
            sortOrder: 1
        )
        sheetDetents.category = navigationSheets
        sheetDetents.snippets = [
            CodeSnippet(language: "SwiftUI", code:
        """
        .sheet(isPresented: $showFilter) {
            FilterOptionsView()
                .presentationDetents([.medium, .large])
                .presentationDragIndicator(.visible)
                .presentationCornerRadius(24)
        }
        """, sortOrder: 0)
        ]
        sheetDetents.references = [
            ArticleReference(title: "Apple HIG · Sheets", url: "[https://developer.apple.com/design/human-interface-guidelines/sheets](https://developer.apple.com/design/human-interface-guidelines/sheets)")
        ]
        
        [navigationStackPatterns, sheetDetents].forEach { context.insert($0) }
        
        // MARK: - SwiftUI Patterns Articles
        
        let environment = Article(
            title: "Environment & State Detection",
            summary: "Detecting system settings and user preferences in real time.",
            body: """
        # Environment & State Detection
        
        SwiftUI's `@Environment` lets you respond to system settings in real time without extra setup.
        
        ## Dynamic Type Detection
        
        `@Environment(\\.dynamicTypeSize)` gives you the current text size category.
        
        Use this to adapt layouts:
        - Larger sizes = switch from 2-column to 1-column grid
        - Adjust padding and spacing
        - Recalculate container heights
        
        ## Other useful Environment variables
        
        - `\\.colorScheme` — Light or Dark mode
        - `\\.horizontalSizeClass` — Compact or Regular width
        - `\\.verticalSizeClass` — Compact or Regular height
        - `\\.isEnabled` — Is the view enabled?
        - `\\.accessibilityReduceMotion` — Is reduce motion active?
        
        ## Computing heights based on Dynamic Type
        
        Calculate line height using `UIFont.preferredFont()`:
        
        1. Convert SwiftUI's `DynamicTypeSize` to UIKit's `UIContentSizeCategory`
        2. Create `UITraitCollection` with that category
        3. Get the appropriate font with `UIFont.preferredFont(forTextStyle:compatibleWith:)`
        4. Use `lineHeight` to compute your component's total height
        
        This ensures your component renders correctly at any text size.
        
        ## Testing multiple conditions
        
        Test your component at different text sizes, screen sizes, and color schemes in previews.
        """,
            hig: "Use Environment to detect system settings and adapt your interface accordingly.",
            higSource: "Apple Documentation · SwiftUI · Environment",
            sortOrder: 0
        )
        environment.category = swiftui
        environment.snippets = [
            CodeSnippet(language: "SwiftUI", code:
        """
        @Environment(\\.dynamicTypeSize) var dynamicTypeSize
        
        var cardHeightDetect: CGFloat {
            // 1. Convert SwiftUI DynamicTypeSize to UIKit
            let sizeCategory = UIContentSizeCategory(dynamicTypeSize)
            
            // 2. Create TraitCollection
            let traitCollection = UITraitCollection(
                preferredContentSizeCategory: sizeCategory
            )
            
            // 3. Get fonts aware of accessibility
            let title2Font = UIFont.preferredFont(
                forTextStyle: .title2,
                compatibleWith: traitCollection
            )
            let title3Font = UIFont.preferredFont(
                forTextStyle: .title3,
                compatibleWith: traitCollection
            )
            
            // 4. Calculate total height
            let title2Height = title2Font.lineHeight
            let title3Height = title3Font.lineHeight
            let totalPadding: CGFloat = 32 + 64
            
            return title2Height + title3Height + totalPadding
        }
        """, sortOrder: 0),
            CodeSnippet(language: "SwiftUI", code:
        """
        var columns: [GridItem] {
            if dynamicTypeSize >= .accessibility1 {
                return [GridItem(.flexible())]
            } else {
                return [
                    GridItem(.flexible()),
                    GridItem(.flexible())
                ]
            }
        }
        """, sortOrder: 1)
        ]
        environment.references = [
            ArticleReference(title: "SwiftUI Environment", url: "[https://developer.apple.com/documentation/swiftui/environment](https://developer.apple.com/documentation/swiftui/environment)"),
            ArticleReference(title: "UIFont preferredFont", url: "[https://developer.apple.com/documentation/uikit/uifont/1619030-preferredfont](https://developer.apple.com/documentation/uikit/uifont/1619030-preferredfont)")
        ]
        
        let models = Article(
            title: "SwiftData Models & Actors",
            summary: "Structuring data safely and persistently.",
            body: """
        # SwiftData Models & Actors
        
        SwiftData makes it easy to define models. Actors keep data access thread-safe.
        
        ## @Model macro
        
        `@Model` macro automatically handles SwiftData persistence and relationships automatically.
        
        Key points:
        - Mark unique properties with `@Attribute(.unique)`
        - Use `@Relationship` to define relationships
        - `deleteRule: .cascade` deletes child objects when parent is deleted
        - Always use `final class` to prevent unexpected subclassing
        
        ## Actors for thread safety
        
        Use `@MainActor` for properties that must be on the main thread. This prevents data races when accessing from background threads.
        
        ## Relationships
        
        **One-to-many:** Article has many CodeSnippets
        **Inverse:** CodeSnippet references back to Article via `inverse: \\Article.snippets`
        
        The `inverse` parameter keeps both sides in sync automatically.
        
        ## Good practices
        
        - Keep models simple and focused
        - Use structs for value types, classes for reference types
        - Always use `final class` to prevent unexpected subclassing
        - Initialize with default values to avoid crashes
        """,
            hig: "Design models that reflect your domain. Keep actors thread-safe.",
            higSource: "Apple Documentation · SwiftData · Modeling",
            sortOrder: 1
        )
        models.category = swiftui
        models.snippets = [
            CodeSnippet(language: "Swift", code:
        """
        @Model
        final class Article {
            @Attribute(.unique) var id: UUID
            var title: String
            var summary: String
            var body: String
            
            var category: ArticleCategory?
            
            @Relationship(deleteRule: .cascade, inverse: \\CodeSnippet.article)
            var snippets: [CodeSnippet] = []
            
            @Relationship(deleteRule: .cascade, inverse: \\ArticleReference.article)
            var references: [ArticleReference] = []
            
            init(id: UUID = UUID(), title: String, summary: String, body: String) {
                self.id = id
                self.title = title
                self.summary = summary
                self.body = body
            }
        }
        """, sortOrder: 0),
            CodeSnippet(language: "Swift", code:
        """
        @MainActor
        final class GrasppStore: ObservableObject {
            static let shared = GrasppStore()
            private init() {}
            
            @Published private(set) var favoriteIDs: [UUID] = {
                let raw = UserDefaults.standard
                    .stringArray(forKey: "graspp.favorites") ?? []
                return raw.compactMap { UUID(uuidString: $0) }
            }()
            
            func toggleFavorite(_ article: Article) {
                if favoriteIDs.contains(article.id) {
                    favoriteIDs.removeAll { $0 == article.id }
                } else {
                    favoriteIDs.append(article.id)
                }
                persist()
            }
            
            private func persist() {
                UserDefaults.standard.set(
                    favoriteIDs.map(\\.uuidString),
                    forKey: "graspp.favorites"
                )
            }
        }
        """, sortOrder: 1)
        ]
        models.references = [
            ArticleReference(title: "Apple Developer · SwiftData", url: "[https://developer.apple.com/documentation/swiftdata](https://developer.apple.com/documentation/swiftdata)")
        ]
        
        let previews = Article(
            title: "Preview Patterns",
            summary: "Testing components at different states and sizes.",
            body: """
        # Preview Patterns
        
        Previews let you iterate fast without rebuilding the entire app.
        
        ## Basic preview
        
        Start with a simple preview that wraps your component with its model container.
        
        ## Multiple states
        
        Test your component in different conditions by creating previews for each state.
        
        ## Dynamic Type preview
        
        Test at multiple text sizes using environment modifiers to simulate different accessibility sizes.
        
        ## Device preview
        
        Use named previews to test on different device types.
        
        ## Empty state preview
        
        Always test empty state alongside populated state to catch layout issues.
        
        ## Setup with preview data
        
        Create a dedicated preview setup function to initialize stores and mock data. Then use it in your previews.
        
        ## Pro tip
        
        Create a dedicated preview view that handles initialization internally. This keeps your preview code clean and reusable.
        """,
            hig: "Use previews to iterate quickly on design and test edge cases.",
            higSource: "Apple Documentation · SwiftUI · Previews",
            sortOrder: 2
        )
        previews.category = swiftui
        previews.snippets = [
            CodeSnippet(language: "SwiftUI", code:
        """
        struct CardArticleListPreview: View {
            init() {
                setupPreviewStore()
            }
            
            var body: some View {
                NavigationStack {
                    CardArticleList(article: sampleArticle, highlight: "")
                        .modelContainer(previewContainer)
                }
            }
        }
        
        """, sortOrder: 0),
            
            CodeSnippet(language: "SwiftUI", code:
                            
                                """
        
        #Preview("Default") {
            CardArticleListPreview()
        }
        
        #Preview("With highlight") {
            CardArticleList(article: sampleArticle, highlight: "how ios")
                .padding()
        }
        
        """, sortOrder: 0),
            
            CodeSnippet(language: "SwiftUI", code:
                                """
        
        #Preview("All Dynamic Type sizes") {
            ForEach(DynamicTypeSize.allCases, id: \\.self) { size in
                CardArticleList(article: sampleArticle)
                    .environment(\\.dynamicTypeSize, size)
                    .padding()
            }
        }
        """, sortOrder: 0)
        ]
        previews.references = [
            ArticleReference(title: "SwiftUI Previews Documentation", url: "[https://developer.apple.com/documentation/swiftui/previews](https://developer.apple.com/documentation/swiftui/previews)")
        ]
        
        let textHighlight = Article(
            title: "Text Highlighting in Search",
            summary: "Highlighting search queries within results.",
            body: """
        # Text Highlighting in Search
        
        When users search and see results, highlighting the matched terms helps them quickly verify the match is relevant.
        
        ## The extension approach
        
        Create an extension on `String` that returns an `AttributedString` with highlighted portions. Use `range(of:options:)` to find matches case-insensitively, then apply bold font and color to matched ranges.
        
        ## Case-insensitive matching
        
        The `range(of:options:)` method with `.caseInsensitive` matches "design", "Design", and "DESIGN" all the same. The original casing is preserved in the display — only the color changes.
        
        ## Performance
        
        For long lists, avoid highlighting on every cell recalculation. Instead, highlight only in the results view or cache the highlighted version.
        """,
            hig: "Use highlighting to help users quickly identify why a result matches their search query.",
            higSource: "Apple HIG · Search",
            sortOrder: 3
        )
        textHighlight.category = swiftui
        textHighlight.snippets = [
            CodeSnippet(language: "SwiftUI", code:
        """
        extension String {
            func highlighted(query: String, color: Color = .yellow, baseColor: Color = .primary) -> Text {
                guard !query.isEmpty else {
                    return Text(self).foregroundStyle(baseColor)
                }
                
                var attributed = AttributedString(self)
                var searchRange = attributed.startIndex..<attributed.endIndex
                attributed.foregroundColor = UIColor(baseColor)
                
                while let range = attributed[searchRange].range(of: query, options: .caseInsensitive) {
                    attributed[range].font = .body.bold()
                    attributed[range].foregroundColor = UIColor(color)
                    searchRange = range.upperBound..<attributed.endIndex
                }
                
                return Text(attributed)
            }
        }
        """, sortOrder: 0)
        ]
        textHighlight.references = [
            ArticleReference(title: "Apple HIG · Search", url: "[https://developer.apple.com/design/human-interface-guidelines/search](https://developer.apple.com/design/human-interface-guidelines/search)")
        ]
        
        [environment, models, previews, textHighlight].forEach { context.insert($0) }
        
        // MARK: - Accessibility Articles
        
        let accessibilityBasics = Article(
            title: "Accessibility Basics",
            summary: "Building apps that work for everyone.",
            body: """
        # Accessibility Basics
        
        Accessibility is not a feature. It is a prerequisite. One in four Americans have a disability. Building accessible apps is building for them.
        
        ## Four categories
        
        **Vision** — blindness, low vision, color blindness. Solutions: VoiceOver, high contrast, text sizing.
        
        **Hearing** — deafness, hard of hearing. Solutions: captions, sound indicators, haptic feedback.
        
        **Motor** — limited movement, tremor, paralysis. Solutions: large tap targets (44pt), voice control, switch control.
        
        **Cognitive** — dyslexia, autism, ADHD. Solutions: clear language, consistent layout, reduced motion.
        
        ## Apple's Accessibility Nutrition Label
        
        Apple publishes accessibility attributes for every app. Users check these before downloading:
        - Larger Text support
        - Sufficient Contrast
        - VoiceOver support
        - Switch Control support
        - Reduce Motion support
        
        ## Minimum requirements
        
        To pass Apple's requirements and avoid App Store rejection:
        1. Support Dynamic Type (Larger Text)
        2. Use semantic colors (Sufficient Contrast)
        3. Label all images for VoiceOver
        4. Make tap targets 44pt minimum
        5. Test with Accessibility Inspector
        
        ## Testing
        
        Enable these in Settings and use the app as a real user:
        - `Accessibility > Display > Larger Text` (at AX1, AX3, AX5)
        - `Accessibility > Display > Increase Contrast`
        - `Accessibility > Vision > VoiceOver`
        - `Accessibility > Motor > Reduce Motion`
        
        If the app breaks at any of these settings, your accessibility is incomplete.
        """,
            hig: "Accessibility improves usability for everyone. Universal design benefits all users, not just those with disabilities.",
            higSource: "Apple HIG · Accessibility",
            sortOrder: 0
        )
        accessibilityBasics.category = accessibility
        accessibilityBasics.references = [
            ArticleReference(title: "Apple HIG · Accessibility", url: "[https://developer.apple.com/design/human-interface-guidelines/accessibility](https://developer.apple.com/design/human-interface-guidelines/accessibility)")
        ]
        
        let voiceOver = Article(
            title: "VoiceOver Support",
            summary: "Making your app readable by screen readers.",
            body: """
        # VoiceOver Support
        
        VoiceOver is iOS's screen reader. It reads your interface aloud so blind and low-vision users can navigate.
        
        ## Label all images
        
        Every image must have an `accessibilityLabel`. If the image is decorative only, use `accessibilityHidden(true)`.
        
        ## Describe actions
        
        Buttons need clear labels describing what they do, not just "Button". Use `accessibilityLabel` to specify the action.
        
        ## Announce state changes
        
        When content changes based on user action, update the accessibility label to reflect the new state.
        
        ## Test with VoiceOver
        
        `Settings > Accessibility > Vision > VoiceOver`
        - Swipe right to move forward, swipe left to move backward.
        - Double-tap to activate.
        
        Listen to how VoiceOver announces your app. If the announcement is confusing, your label is wrong.
        
        ## VoiceOver hints
        
        Use hints only when necessary. If the label is clear, you don't need a hint.
        
        ```swift
        Button("Add") {
            // ...
        }
        .accessibilityHint("Add a new item to your list")
        ```
        
        Hints add verbosity. Only use if the action is not obvious from the label.
        """,
            hig: "Make sure your app is usable with VoiceOver. Provide clear, concise labels and hints.",
            higSource: "Apple HIG · Accessibility · VoiceOver",
            sortOrder: 1
        )
        voiceOver.category = accessibility
        voiceOver.snippets = [
            CodeSnippet(language: "SwiftUI", code:
        """
        Image("logo")
            .accessibilityLabel("Company logo")
        
        Image("decorative-line")
            .accessibilityHidden(true)
        """, sortOrder: 0),
            CodeSnippet(language: "SwiftUI", code:
        """
        Button(action: { /* ... */ }) {
            Image(systemName: "heart")
        }
        .accessibilityLabel("Add to favorites")
        """, sortOrder: 1),
            CodeSnippet(language: "SwiftUI", code:
        """
        @State private var isFavorite = false
        
        var body: some View {
            Button("Favorite") {
                isFavorite.toggle()
            }
            .accessibilityElement(children: .ignore)
            .accessibilityLabel(isFavorite ? "Favorited" : "Not favorited")
        }
        """, sortOrder: 2)
        ]
        voiceOver.references = [
            ArticleReference(title: "Apple HIG · Accessibility · VoiceOver", url: "[https://developer.apple.com/design/human-interface-guidelines/accessibility](https://developer.apple.com/design/human-interface-guidelines/accessibility)")
        ]
        
        let reduceMotion = Article(
            title: "Respecting User Motion Preferences",
            summary: "Disabling animations for users who prefer reduced motion.",
            body: """
        # Respecting User Motion Preferences
        
        Some users get motion sickness from animations. Others find excessive motion distracting. "Reduce Motion" is a system accessibility setting.
        
        ## When Reduce Motion is enabled
        
        Disable:
        - Long animations (> 300ms)
        - Parallax effects
        - Page transitions with movement
        - Auto-playing videos
        - Jittery or shaky effects
        
        Keep:
        - Essential feedback (like a button press)
        - UI state changes (like expanding a section)
        - Minimal motion for orientation changes
        
        ## Implementation
        
        Check `@Environment(\\.accessibilityReduceMotion)` to detect the user's preference, then conditionally apply animations only when reduce motion is disabled.
        
        ## Testing
        
        `Settings > Accessibility > Motion > Reduce Motion`
        
        Enable it and use your app. Animations should be significantly simplified.
        
        ## Rule of thumb
        
        If an animation is longer than a typical user gesture (< 300ms), respect Reduce Motion by removing it.
        """,
            hig: "Respect the Reduce Motion accessibility setting by minimizing animations.",
            higSource: "Apple HIG · Accessibility · Motion",
            sortOrder: 2
        )
        reduceMotion.category = accessibility
        reduceMotion.snippets = [
            CodeSnippet(language: "SwiftUI", code:
        """
        @Environment(\\.accessibilityReduceMotion) var reduceMotion
        
        var animationDuration: Double {
            reduceMotion ? 0 : 0.3
        }
        
        var body: some View {
            Text("Hello")
                .transition(.move(edge: .bottom))
                .animation(
                    reduceMotion ? nil : .easeInOut(duration: 0.3),
                    value: isShown
                )
        }
        """, sortOrder: 0)
        ]
        reduceMotion.references = [
            ArticleReference(title: "Apple HIG · Accessibility · Motion", url: "[https://developer.apple.com/design/human-interface-guidelines/motion](https://developer.apple.com/design/human-interface-guidelines/motion)")
        ]
        
        [accessibilityBasics, voiceOver, reduceMotion].forEach { context.insert($0) }
        
        // MARK: - Persist to Context
        try? context.save()
    }
}
