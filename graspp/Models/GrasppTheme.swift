//
//  GrasppTheme.swift
//  graspp
//
//  Created by Nadia Putri Natali Lubis on 18/06/26.
//

import Foundation
import MarkdownUI
import SwiftUI

// MARK: - Theme
extension Theme {
    static let graspp = Theme()
        // Paragraph: Slightly tighter bottom margin for a cleaner reading rhythm
        .paragraph { config in
            config.label
                .relativeLineSpacing(.em(0.24))
                .markdownMargin(top: .zero, bottom: .em(0.85))
        }
        
        // Headings: Balanced margins and clear hierarchical scale
        .heading1 { config in
            config.label
                .markdownTextStyle {
                    FontWeight(.bold)
                    FontSize(.em(1.35))
                }
                .relativeLineSpacing(.em(0.12))
                .markdownMargin(top: .em(1.5), bottom: .em(0.35))
        }
        .heading2 { config in
            config.label
                .markdownTextStyle {
                    FontWeight(.semibold)
                    FontSize(.em(1.15))
                }
                .relativeLineSpacing(.em(0.12))
                .markdownMargin(top: .em(1.3), bottom: .em(0.25))
        }
        .heading3 { config in
            config.label
                .markdownTextStyle {
                    FontWeight(.semibold)
                    FontSize(.em(0.95))
                    ForegroundColor(.secondary)
                }
                .relativeLineSpacing(.em(0.12))
                .markdownMargin(top: .em(1.0), bottom: .em(0.2))
        }
        
        // List items: Adjusted spacing between consecutive list rows
        .listItem { config in
            config.label
                .markdownMargin(top: .em(0.3))
                .relativeLineSpacing(.em(0.2))
        }
        
        // Inline code: Tuned font scale and padding feel
        .code {
            FontFamilyVariant(.monospaced)
            FontSize(.em(0.88))
            BackgroundColor(Color(.systemGray5))
        }
        
        // Code Block: Clean vertical margins
        .codeBlock { config in
            config.label
                .markdownTextStyle {
                    FontFamilyVariant(.monospaced)
                    FontSize(.em(0.88))
                    BackgroundColor(Color(.systemGray5))
                }
                .markdownMargin(top: .em(0.6), bottom: .em(0.85))
        }
        
        // Tables: Refined vertical spacing and comfortable cell padding
        .table { config in
            config.label
                .fixedSize(horizontal: false, vertical: true)
                .markdownTableBorderStyle(.init(.horizontalBorders, color: Color(.separator)))
                .markdownMargin(top: .em(0.9), bottom: .em(0.9))
        }
        .tableCell { config in
            config.label
                .markdownTextStyle {
                    if config.row == 0 { FontWeight(.semibold) }
                }
                .fixedSize(horizontal: false, vertical: true)
                .relativeLineSpacing(.em(0.2))
                .relativePadding(length: .rem(0.5))
        }
}
