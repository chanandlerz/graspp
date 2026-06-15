//
//  ArticleListScreen.swift
//  graspp
//
//  Created by Nadia Putri Natali Lubis on 15/06/26.
//

import SwiftUI

struct ArticleListScreen: View {
    var body: some View {
        ScrollView {
            VStack (spacing: 12){
                Text("Design Fundamentals")
                    .font(Font.largeTitle.bold())
                
//                Color.clear.frame(height: 8)
                
                ForEach(0..<5) {_ in
                    CardArticleList(articleTitle:"Typeface vs Font long",description:"One line description text here.", iconAccent: AnyShapeStyle(.indigo)
                    )
                }
            }
        }
        .background(Color(.systemGroupedBackground))
    }}

#Preview {
    ArticleListScreen()
}
