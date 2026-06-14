//
//  FavoritesProgressive.swift
//  graspp
//
//  Created by Nadia Putri Natali Lubis on 13/06/26.
//

import SwiftUI

struct FavoritesProgressive: View {
    var body: some View {
        VStack (spacing: 14) {
            HStack (spacing: 16){
                Text("Favorites")
                    .font(.title2)
                    .fontWeight(.bold)
                Image(systemName: "chevron.right")
                    .font(.title2)
                    .fontWeight(.bold)
                    .foregroundColor(.secondary)
                Spacer()
            }
            
            HStack(spacing: 12){
                CardFavorite(symbolName:"textformat", articleTitle:"Typeface vs Font long",categoryName:"Typography",iconAccent: AnyShapeStyle(.indigo))
                CardFavorite(symbolName:"textformat", articleTitle:"Typeface vs Font",categoryName:"Typography",iconAccent: AnyShapeStyle(.indigo))
            }
            
            HStack(spacing: 12){
                CardFavorite(symbolName:"textformat", articleTitle:"Typeface vs Font",categoryName:"Typography",iconAccent: AnyShapeStyle(.indigo))
                CardFavorite(symbolName:"textformat", articleTitle:"Typeface vs Font",categoryName:"Typography",iconAccent: AnyShapeStyle(.indigo))
            }

            
        }
        .padding(.horizontal, 16)
    }
}

#Preview {
    FavoritesProgressive()
}
