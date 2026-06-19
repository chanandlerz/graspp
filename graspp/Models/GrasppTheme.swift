//
//  GrasppTheme.swift
//  graspp
//
//  Created by Nadia Putri Natali Lubis on 18/06/26.
//

import Foundation
import MarkdownUI
import SwiftUI

// MARK: Theme
extension Theme {
    static let graspp = Theme()
        .paragraph { config in
            config.label
                .relativeLineSpacing(.em(0.25))
                .markdownMargin(top: .zero, bottom: .em(1.0))
        }
        .heading1 { config in
            config.label
                .markdownTextStyle {
                    FontWeight(.bold)
                    FontSize(.em(1.3))
                }
                .relativeLineSpacing(.em(0.12))
                .markdownMargin(top: .em(1.8), bottom: .em(0.3))
        }
        .heading2 { config in
            config.label
                .markdownTextStyle {
                    FontWeight(.semibold)
                    FontSize(.em(1.1))
                }
                .relativeLineSpacing(.em(0.12))
                .markdownMargin(top: .em(1.5), bottom: .em(0.2))
        }
        .heading3 { config in
            config.label
                .markdownTextStyle {
                    FontWeight(.semibold)
                    FontSize(.em(0.95))
                    ForegroundColor(.secondary)
                }
                .relativeLineSpacing(.em(0.12))
                .markdownMargin(top: .em(1.2), bottom: .em(0.2))
        }
        .listItem { config in
            config.label
                .markdownMargin(top: .em(0.4))
                .relativeLineSpacing(.em(0.2))
        }
        .code {
            FontFamilyVariant(.monospaced)
            FontSize(.em(0.9))
            BackgroundColor(Color(.systemGray5))
        }
        .codeBlock { config in
            config.label
                .markdownTextStyle {
                    FontFamilyVariant(.monospaced)
                    FontSize(.em(0.9))
                    BackgroundColor(Color(.systemGray5))
                }
        }
        .table { config in
            config.label
                .fixedSize(horizontal: false, vertical: true)
                .markdownTableBorderStyle(.init(.horizontalBorders, color: Color(.separator)))
                .markdownMargin(top: .em(1.2), bottom: .em(1.0))
        }
        .tableCell { config in
            config.label
                .markdownTextStyle {
                    if config.row == 0 { FontWeight(.semibold) }
                }
                .fixedSize(horizontal: false, vertical: true)
                .relativeLineSpacing(.em(0.235295))
                .relativePadding(length: .rem(0.58824))
        }
}
