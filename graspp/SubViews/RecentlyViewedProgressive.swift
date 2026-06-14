//
//  RecentlyViewedProgressive.swift
//  graspp
//
//  Created by Nadia Putri Natali Lubis on 14/06/26.
//

import SwiftUI

struct RecentlyViewedProgressive: View {
    var body: some View {
        VStack (spacing: 14){
            HStack (spacing: 16){
                Text("Recently viewed")
                    .font(.title2)
                    .fontWeight(.bold)
                Image(systemName: "chevron.right")
                    .font(.title2)
                    .fontWeight(.bold)
                    .foregroundColor(.secondary)
                Spacer()
            }
            
            VStack (spacing: 12){
                CardArticleCategory(articleTitle:"Typeface vs Font long",categoryName:"Typography", iconAccent: AnyShapeStyle(.indigo)
                )
                CardArticleCategory(articleTitle:"Typeface vs Font long",categoryName:"Typography", iconAccent: AnyShapeStyle(.indigo)
                )
                CardArticleCategory(articleTitle:"Typeface vs Font long",categoryName:"Typography", iconAccent: AnyShapeStyle(.indigo)
                )
                CardArticleCategory(articleTitle:"Typeface vs Font long",categoryName:"Typography", iconAccent: AnyShapeStyle(.indigo)
                )
                CardArticleCategory(articleTitle:"Typeface vs Font long",categoryName:"Typography", iconAccent: AnyShapeStyle(.indigo)
                )
            }
            
        }
        .padding(.horizontal, 16)
    }
}

#Preview {
    RecentlyViewedProgressive()
}
