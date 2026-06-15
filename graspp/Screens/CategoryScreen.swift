//
//  CategoryScreen.swift
//  graspp
//
//  Created by Nadia Putri Natali Lubis on 14/06/26.
//

import SwiftUI

struct CategoryScreen: View {
    let columns = [GridItem(.flexible()), GridItem(.flexible())]
    
    var body: some View {
        ScrollView {
            VStack (spacing: 12){
                Text("Favorite")
                    .font(Font.largeTitle.bold())
                
                Color.clear.frame(height: 8)
                
                HStack(spacing: 12) {
                    CardCategory(symbolName:"textformat", categoryName:"Typography", iconAccent: AnyShapeStyle(.indigo)
                    )
                    CardCategory(symbolName:"textformat", categoryName:"Design Fundamentals", iconAccent: AnyShapeStyle(.indigo)
                    )
                }
                
                HStack(spacing: 12) {
                    CardCategory(symbolName:"textformat", categoryName:"Typography", iconAccent: AnyShapeStyle(.indigo)
                    )
                    CardCategory(symbolName:"textformat", categoryName:"Design Fundamentals", iconAccent: AnyShapeStyle(.indigo)
                    )
                }
                
            }
        }
        .background(Color(.systemGroupedBackground))    }
}

#Preview {
    CategoryScreen()
}
