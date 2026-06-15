//
//  CardCategory.swift
//  graspp
//
//  Created by Nadia Putri Natali Lubis on 14/06/26.
//

import SwiftUI

struct CardCategory: View {
    let symbolName: String
    let categoryName: String
    let iconAccent: AnyShapeStyle
    
    @Environment(\.dynamicTypeSize) var dynamicTypeSize
    
    var singleLineHeight: CGFloat {
        UIFont.preferredFont(forTextStyle: .title3).lineHeight
    }
    
    var maxTextHeight: CGFloat {
        singleLineHeight * 2.2
    }
    
    var cardHeight: CGFloat {
        switch dynamicTypeSize {
        case .xSmall, .small, .medium, .large: return 153
        case .xLarge: return 153
        case .xxLarge: return 153
        case .xxxLarge: return 210
        case .accessibility1: return 240
        case .accessibility2: return 280
        case .accessibility3: return 320
        case .accessibility4: return 370
        case .accessibility5: return 420
        @unknown default: return 153
        }
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
                Image(systemName: symbolName)
                    .font(.title2)
                    .fontWeight(.medium)
                    .foregroundStyle(iconAccent)
                    .frame(width: dynamicTypeSize.isAccessibilitySize ? 64 : 52, height: dynamicTypeSize.isAccessibilitySize ? 64 : 52)
                    .background(.ultraThinMaterial, in: Circle())
            }
                        
//            Color.clear.frame(height: 16)

            Spacer()
            
            VStack{
                Text(categoryName)
                    .lineLimit(2)
                    .font(.title3)
                    .fontWeight(.bold)
                    .fixedSize(horizontal: false, vertical: true)
            }
            .frame(maxWidth: .infinity, alignment: .init(horizontal: .leading, vertical: .bottom))
                            
        }
        .padding(16)
        .frame(width: 181, height: cardHeightDetect)
        .frame(minHeight: 153, alignment: .topLeading)
        .glassEffect(.regular, in: RoundedRectangle(cornerRadius: 10))
    }
}

#Preview {
    HStack{
        CardCategory(symbolName:"textformat", categoryName:"Typography", iconAccent: AnyShapeStyle(.indigo)
        )
        CardCategory(symbolName:"textformat", categoryName:"Design Fundamentals", iconAccent: AnyShapeStyle(.indigo)
        )
    }

}
