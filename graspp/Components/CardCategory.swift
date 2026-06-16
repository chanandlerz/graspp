//
//  CardCategory.swift
//  graspp
//
//  Created by Nadia Putri Natali Lubis on 14/06/26.
//

import SwiftUI

struct CardCategory: View {
    
    let category: ArticleCategory
        
    @Environment(\.dynamicTypeSize) var dynamicTypeSize
    
    var singleLineHeight: CGFloat {
        UIFont.preferredFont(forTextStyle: .title3).lineHeight
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
        let title3Font = UIFont.preferredFont(forTextStyle: .title3, compatibleWith: traitCollection)
        
        // 4. Hitung total height
        let title2Height = title2Font.lineHeight
        let title3Height = title3Font.lineHeight

        
        let totalPadding: CGFloat = 32.0 + 64.0 // Total padding vertikal luar & dalam
        
        return title2Height + title3Height + totalPadding
    }

    
    var body: some View {
        VStack (alignment: .leading, spacing: 0){
            HStack{
                Spacer()
                Image(systemName: category.icon)
                    .font(.title2)
                    .fontWeight(.medium)
                    .foregroundStyle(category.color)
                    .frame(width: dynamicTypeSize.isAccessibilitySize ? 64 : 52, height: dynamicTypeSize.isAccessibilitySize ? 64 : 52)
                    .background(.ultraThinMaterial, in: Circle())
            }
                        
            Spacer()
            
            Text(category.name)
                .lineLimit(2)
                .font(.title3)
                .foregroundColor(.primary)
                .fontWeight(.bold)
                .fixedSize(horizontal: false, vertical: true)
                .frame(maxWidth: .infinity, alignment: .leading)
                .multilineTextAlignment(.leading)
            
        }
        .padding(16)
        .frame(maxWidth: .infinity)
        .frame(height: cardHeightDetect)
        .frame(minHeight: 153, alignment: .topLeading)
        .glassEffect(.regular, in: RoundedRectangle(cornerRadius: 10))
    }
}

#Preview {
    let cat = ArticleCategory(name: "Typography", icon: "textformat", colorName: "purple", sortOrder: 0)
        HStack {
            CardCategory(category: cat)
            CardCategory(category: ArticleCategory(name: "Design Fundamentals", icon: "lightbulb", colorName: "blue", sortOrder: 3))
        }
}
