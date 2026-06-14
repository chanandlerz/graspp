//
//  HomeScreen.swift
//  graspp
//
//  Created by Nadia Putri Natali Lubis on 13/06/26.
//

import SwiftUI

struct HomeScreen: View {
    var body: some View {
        ScrollView {
            VStack (spacing: 24){
                Text("Graspp")
                    .font(Font.largeTitle.bold())
                
                FavoritesProgressive()
                RecentlyViewedProgressive()
                Spacer()
            }
        }
        .background(Color(.systemGroupedBackground))
    }
}

#Preview {
    HomeScreen()
}
