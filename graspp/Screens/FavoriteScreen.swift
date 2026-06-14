//
//  FavoriteScreen.swift
//  graspp
//
//  Created by Nadia Putri Natali Lubis on 14/06/26.
//

import SwiftUI

struct FavoriteScreen: View {
    var body: some View {
        ScrollView {
            VStack (spacing: 12){
                Text("Favorite")
                    .font(Font.largeTitle.bold())
                
                Color.clear.frame(height: 8)
                
                ForEach(0..<10) {_ in
                    HStack (spacing: 12){
                        CardFavorite(symbolName:"textformat", articleTitle:"Typeface vs Font long",categoryName:"Typography", iconAccent: AnyShapeStyle(.indigo))
                    
                        CardFavorite(symbolName:"textformat", articleTitle:"Typeface vs Font long",categoryName:"Typography", iconAccent: AnyShapeStyle(.indigo))

                    }
                }
            }
        }
        .background(Color(.systemGroupedBackground))
    }
}

#Preview {
    FavoriteScreen()
}

