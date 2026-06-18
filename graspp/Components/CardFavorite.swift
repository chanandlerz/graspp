//
//  CardFavorite.swift
//  graspp
//
//  Created by Nadia Putri Natali Lubis on 13/06/26.
//

import SwiftUI

struct CardFavorite: View {
    
    let article: Article
//    let symbolName: String
//    let articleTitle: String
//    let categoryName: String
//    let iconAccent: AnyShapeStyle
    
    @Environment(\.dynamicTypeSize) var dynamicTypeSize
    
    var singleLineHeight: CGFloat {
        UIFont.preferredFont(forTextStyle: .headline).lineHeight
    }
    
    var maxTextHeight: CGFloat {
        singleLineHeight * 2.2
    }
        
    var cardHeightDetect: CGFloat {
        // 1. Convert SwiftUI DynamicTypeSize ke UIKit UIContentSizeCategory
        let sizeCategory = UIContentSizeCategory(dynamicTypeSize)
        
        // 2. Buat Trait Collection berdasarkan size tersebut
        let traitCollection = UITraitCollection(preferredContentSizeCategory: sizeCategory)
        
        // 3. Ambil font yang sudah "aware" dengan environment-nya
        let title2Font = UIFont.preferredFont(forTextStyle: .title2, compatibleWith: traitCollection)
        let headlineFont = UIFont.preferredFont(forTextStyle: .headline, compatibleWith: traitCollection)
        let calloutFont = UIFont.preferredFont(forTextStyle: .callout, compatibleWith: traitCollection)
        
        // 4. Hitung total height
        let titleHeight = title2Font.lineHeight
        let headlineHeight = headlineFont.lineHeight * 2 // Sebaiknya pakai angka bulat untuk jumlah baris
        let calloutHeight = calloutFont.lineHeight
        
        let totalPadding: CGFloat = 32.0 + 64.0 // Total padding vertikal luar & dalam
        
        return titleHeight + headlineHeight + calloutHeight + totalPadding
    }
    
    var body: some View {
        VStack (alignment: .leading, spacing: 0){
            Image(systemName: article.category?.icon ?? "")
                .font(.title2)
                .fontWeight(.medium)
                .foregroundStyle(article.category?.color ?? .blue)
                .frame(width: dynamicTypeSize.isAccessibilitySize ? 64 : 52, height: dynamicTypeSize.isAccessibilitySize ? 64 : 52)
                .background(.ultraThinMaterial, in: Circle())
            
//            Color.clear.frame(height: 16)
            Spacer()
            
            VStack (alignment: .leading, spacing: 4){
                Text(article.title)
                    .font(.headline)
                    .lineLimit(2)
                    .layoutPriority(1)
                
                
                Text(article.category?.name ?? "")
                    .font(.callout)
                    .foregroundStyle(.secondary)
            }
            .frame(maxWidth: .infinity, alignment: .leading)
            .fixedSize(horizontal: false, vertical: true)
                
        }
        .padding(16)
        .frame(width: 181, height: cardHeightDetect)
        .frame(minHeight: 153)
        .glassEffect(.regular, in: RoundedRectangle(cornerRadius: 10))
    }
}


#Preview {
    CardFavorite(article: sampleArticle)
}
